#!/bin/bash

# OSVMarchi ISO Builder
# Builds bootable Arch Linux ISOs with OSVMarchi pre-installed for different CPU architectures

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="${BUILD_DIR:-$SCRIPT_DIR/iso-build}"
ARCHISO_REPO="https://gitlab.archlinux.org/archlinux/archiso.git"

# Architecture configurations
declare -A ARCH_CONFIGS=(
    ["x86_64"]="generic-x86_64:x86-64:generic"
    ["amd64"]="amd64:x86-64:generic"
    ["zen4"]="zen4-optimized:znver4:znver4"
    ["zen5"]="zen5-optimized:znver5:znver5"
    ["epyc"]="epyc-optimized:znver2:znver2"
    ["threadripper"]="threadripper-optimized:znver3:znver3"
)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on Arch Linux
check_arch_linux() {
    if [[ ! -f /etc/arch-release ]]; then
        log_error "This script must be run on Arch Linux"
        exit 1
    fi
}

# Check if running as root
check_not_root() {
    if [[ $EUID -eq 0 ]]; then
        log_error "This script should not be run as root"
        exit 1
    fi
}

# Install required dependencies
install_dependencies() {
    log_info "Installing required dependencies..."
    
    local deps=(
        archiso
        git
        base-devel
        dosfstools
        e2fsprogs
        erofs-utils
        libarchive
        libisoburn
        mtools
        squashfs-tools
    )
    
    sudo pacman -Sy --needed --noconfirm "${deps[@]}"
    log_success "Dependencies installed"
}

# Setup build environment
setup_build_env() {
    local arch="$1"
    local name="$2"
    local march="$3"
    local mtune="$4"
    
    log_info "Setting up build environment for $name"
    
    # Create build directory
    mkdir -p "$BUILD_DIR/archiso-$arch"
    cd "$BUILD_DIR"
    
    # Clone archiso if not already present
    if [[ ! -d "archiso" ]]; then
        log_info "Cloning archiso repository..."
        git clone "$ARCHISO_REPO" --depth 1
    fi
    
    # Verify archiso was cloned successfully
    if [[ ! -d "archiso/configs/releng" ]]; then
        log_error "Failed to clone archiso repository or releng config not found"
        exit 1
    fi
    
    # Copy archiso profile
    cp -r archiso/configs/releng/* "archiso-$arch/"
    
    # Verify profiledef.sh was copied
    if [[ ! -f "archiso-$arch/profiledef.sh" ]]; then
        log_error "profiledef.sh not found after copy operation"
        ls -la "archiso-$arch/"
        exit 1
    fi
    
    log_success "Build environment setup complete"
}

# Create custom packages list
create_packages_list() {
    local arch="$1"
    
    log_info "Creating custom packages list for $arch"
    
    # Verify OSVMarchi packages.sh exists
    if [[ ! -f "$SCRIPT_DIR/install/packages.sh" ]]; then
        log_error "OSVMarchi packages.sh not found at $SCRIPT_DIR/install/packages.sh"
        exit 1
    fi
    
    # Start with base system packages
    cat > "$BUILD_DIR/archiso-$arch/packages.x86_64" << 'EOF'
# Base system
base
base-devel
linux
linux-firmware

# Bootloader and filesystem
syslinux
efibootmgr
dosfstools
e2fsprogs

# Network and utilities
networkmanager
openssh
git
curl
wget

# Build tools for archiso
archiso

EOF
    
    # Add all OSVMarchi packages from install/packages.sh
    log_info "Adding OSVMarchi packages from install/packages.sh"
    
    # Extract package names from install/packages.sh and add them
    grep -E '^  [a-z]' "$SCRIPT_DIR/install/packages.sh" | sed 's/^  //' | sed 's/ \\$//' | while read -r package; do
        echo "$package" >> "$BUILD_DIR/archiso-$arch/packages.x86_64"
    done
    
    local total_packages
    total_packages=$(wc -l < "$BUILD_DIR/archiso-$arch/packages.x86_64")
    
    log_success "Custom packages list created with $total_packages packages"
}

# Configure OSVMarchi integration
configure_osvmarchi() {
    local arch="$1"
    local name="$2"
    
    log_info "Configuring OSVMarchi integration for $name"
    
    cd "$BUILD_DIR/archiso-$arch"
    
    # Create airootfs structure
    mkdir -p airootfs/etc/systemd/system/multi-user.target.wants
    mkdir -p airootfs/etc/osvmarchi
    mkdir -p airootfs/usr/local/bin
    
    # Copy OSVMarchi files (skip .git and build directories)
    rsync -av --exclude='.git' --exclude='iso-build' --exclude='*.iso' \
          "$SCRIPT_DIR/" airootfs/etc/osvmarchi/
    
    # Create OSVMarchi installer service
    cat > airootfs/etc/systemd/system/osvmarchi-installer.service << EOF
[Unit]
Description=OSVMarchi Installer Service
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/osvmarchi-auto-install
RemainAfterExit=yes
StandardOutput=journal

[Install]
WantedBy=multi-user.target
EOF
    
    # Create auto-installer script
    cat > airootfs/usr/local/bin/osvmarchi-auto-install << EOF
#!/bin/bash
# OSVMarchi Auto Installer for ISO

echo "OSVMarchi ISO Image - $name"
echo "Architecture: $arch"
echo
echo "This ISO contains OSVMarchi pre-configured for $arch processors."
echo "Run 'osvmarchi-install' to begin installation on this system."
echo

# Make OSVMarchi available
if [[ -d /etc/osvmarchi ]]; then
    ln -sf /etc/osvmarchi/boot.sh /usr/local/bin/osvmarchi-install
    chmod +x /usr/local/bin/osvmarchi-install
fi
EOF
    
    chmod +x airootfs/usr/local/bin/osvmarchi-auto-install
    
    # Enable the service
    ln -sf ../osvmarchi-installer.service airootfs/etc/systemd/system/multi-user.target.wants/
    
    log_success "OSVMarchi integration configured"
}

# Configure architecture-specific optimizations
configure_arch_optimizations() {
    local arch="$1"
    local name="$2"
    local march="$3"
    local mtune="$4"
    
    log_info "Configuring architecture optimizations for $name"
    
    cd "$BUILD_DIR/archiso-$arch"
    
    # Create makepkg.conf with architecture optimizations
    cat > airootfs/etc/makepkg.conf << EOF
# Architecture-specific optimizations for $arch
CARCH="x86_64"
CHOST="x86_64-pc-linux-gnu"

# Compiler flags optimized for $arch
CFLAGS="-march=$march -mtune=$mtune -O2 -pipe -fno-plt -fexceptions -Wp,-D_FORTIFY_SOURCE=3 -Wformat -Werror=format-security -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer"
CXXFLAGS="\$CFLAGS -Wp,-D_GLIBCXX_ASSERTIONS"
LDFLAGS="-Wl,-O1 -Wl,--sort-common -Wl,--as-needed -Wl,-z,relro -Wl,-z,now -Wl,-z,pack-relative-relocs"
LTOFLAGS="-flto=auto"
RUSTFLAGS="-C opt-level=2 -C target-cpu=$mtune"

# Make options
MAKEFLAGS="-j\$(nproc)"

# Package options
OPTIONS=(strip docs !libtool !staticlibs emptydirs zipman purge !debug lto)

# Architecture
INTEGRITY_CHECK=(sha256)
BUILDENV=(!distcc color !ccache check !sign)
EOF
    
    log_success "Architecture optimizations configured"
}

# Customize ISO profile
customize_iso_profile() {
    local arch="$1"
    local name="$2"
    
    log_info "Customizing ISO profile for $name"
    
    cd "$BUILD_DIR/archiso-$arch"
    
    # Verify profiledef.sh exists before modification
    if [[ ! -f profiledef.sh ]]; then
        log_error "profiledef.sh not found. Aborting build."
        ls -la .
        exit 1
    fi
    
    # Update profile configuration
    sed -i "s/iso_name=\"archlinux\"/iso_name=\"osvmarchi-$name\"/" profiledef.sh
    sed -i "s/iso_label=\"ARCH_.*\"/iso_label=\"OSVMARCHI_$arch\"/" profiledef.sh
    sed -i "s|iso_publisher=\"Arch Linux <https://archlinux.org>\"|iso_publisher=\"OSVMarchi <https://osvm.archi>\"|" profiledef.sh
    sed -i "s|iso_application=\"Arch Linux Live/Rescue DVD\"|iso_application=\"OSVMarchi Live/Install CD - $name\"|" profiledef.sh
    
    # Verify modifications were applied
    log_info "Modified profiledef.sh contents:"
    grep -E "(iso_name|iso_label|iso_publisher|iso_application)" profiledef.sh
    
    # Set version
    echo "$(date +%Y.%m.%d)-$name" > airootfs/etc/osvmarchi-version
    
    log_success "ISO profile customized"
}

# Build ISO image
build_iso() {
    local arch="$1"
    local name="$2"
    
    log_info "Building ISO for $name architecture..."
    
    cd "$BUILD_DIR/archiso-$arch"
    
    # Build the ISO with verbose output
    if ! sudo mkarchiso -v -w work -o out . 2>&1 | tee build.log; then
        log_error "ISO build failed!"
        cat build.log
        exit 1
    fi
    
    # Check if build was successful
    if [[ ! -d out ]] || [[ -z "$(ls out/*.iso 2>/dev/null)" ]]; then
        log_error "No ISO file found in output directory!"
        ls -la out/ || echo "Output directory does not exist"
        exit 1
    fi
    
    # Get ISO filename
    local iso_file
    iso_file=$(ls out/*.iso | head -1)
    log_info "Built ISO: $iso_file"
    
    # Move to predictable location
    local final_name="osvmarchi-$name-$(date +%Y%m%d).iso"
    sudo mv "$iso_file" "../$final_name"
    sudo chown "$USER:$USER" "../$final_name"
    
    log_success "ISO built successfully: $BUILD_DIR/$final_name"
    
    # Generate checksums
    cd "$BUILD_DIR"
    sha256sum "$final_name" > "$final_name.sha256"
    md5sum "$final_name" > "$final_name.md5"
    
    # Display info
    ls -lh "$final_name"*
    echo "SHA256: $(cat "$final_name.sha256")"
}

# Clean up build directory
cleanup() {
    local arch="$1"
    
    log_info "Cleaning up build directory for $arch"
    rm -rf "$BUILD_DIR/archiso-$arch"
    log_success "Cleanup complete"
}

# Show usage information
show_usage() {
    cat << EOF
OSVMarchi ISO Builder

Usage: $0 [OPTIONS] [ARCHITECTURE]

ARCHITECTURES:
  x86_64       - Generic x86_64 (default)
  amd64        - AMD64 baseline
  zen4         - AMD Ryzen 7000 series optimized
  zen5         - AMD Ryzen 9000 series optimized
  epyc         - AMD EPYC server optimized
  threadripper - AMD Threadripper HEDT optimized
  all          - Build all architectures

OPTIONS:
  -h, --help     Show this help message
  -c, --cleanup  Clean up build directories after build
  -k, --keep     Keep build directories (default)
  -v, --verbose  Enable verbose output

EXAMPLES:
  $0                    # Build generic x86_64 ISO
  $0 zen4               # Build Zen4 optimized ISO
  $0 all                # Build all architecture variants
  $0 -c zen5            # Build Zen5 ISO and cleanup after

EOF
}

# Main function
main() {
    local arch="x86_64"
    local cleanup_after=false
    local build_all=false
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_usage
                exit 0
                ;;
            -c|--cleanup)
                cleanup_after=true
                shift
                ;;
            -k|--keep)
                cleanup_after=false
                shift
                ;;
            -v|--verbose)
                set -x
                shift
                ;;
            all)
                build_all=true
                shift
                ;;
            x86_64|amd64|zen4|zen5|epyc|threadripper)
                arch="$1"
                shift
                ;;
            *)
                log_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done
    
    # Check prerequisites
    check_arch_linux
    check_not_root
    
    log_info "OSVMarchi ISO Builder starting..."
    log_info "Build directory: $BUILD_DIR"
    
    # Install dependencies
    install_dependencies
    
    # Build function for single architecture
    build_arch() {
        local target_arch="$1"
        local config="${ARCH_CONFIGS[$target_arch]}"
        
        if [[ -z "$config" ]]; then
            log_error "Unknown architecture: $target_arch"
            exit 1
        fi
        
        IFS=':' read -r name march mtune <<< "$config"
        
        log_info "Building ISO for $name ($target_arch)"
        
        setup_build_env "$target_arch" "$name" "$march" "$mtune"
        create_packages_list "$target_arch"
        configure_osvmarchi "$target_arch" "$name"
        configure_arch_optimizations "$target_arch" "$name" "$march" "$mtune"
        customize_iso_profile "$target_arch" "$name"
        build_iso "$target_arch" "$name"
        
        if [[ "$cleanup_after" == true ]]; then
            cleanup "$target_arch"
        fi
        
        log_success "Completed build for $name"
    }
    
    # Build ISOs
    if [[ "$build_all" == true ]]; then
        log_info "Building ISOs for all architectures..."
        for target_arch in "${!ARCH_CONFIGS[@]}"; do
            build_arch "$target_arch"
        done
    else
        build_arch "$arch"
    fi
    
    log_success "All builds completed!"
    log_info "ISOs available in: $BUILD_DIR"
}

# Run main function with all arguments
main "$@"