# OSVMarchi Development Instructions

OSVMarchi is an Arch Linux installer and configuration system that transforms a fresh Arch Linux installation into a fully-configured, beautiful, modern Solana and web development environment based on the Hyprland window manager.

**ALWAYS** reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the information here.

## Working Effectively

### System Requirements and Validation
- **CRITICAL**: OSVMarchi ONLY works on vanilla Arch Linux x86_64 systems
- Do NOT attempt to run the installer on Ubuntu, Debian, or other distributions
- The installer includes strict guards that check for:
  - Arch Linux (`/etc/arch-release` must exist)
  - NOT an Arch derivative (no CachyOS, EndeavourOS, Garuda, Manjaro)
  - NOT running as root
  - x86_64 architecture only
  - No existing GNOME or KDE desktop environments

### Repository Structure and Navigation
- `boot.sh` - Downloads OSVMarchi from GitHub and starts installation
- `install.sh` - Main orchestration script (calls all other installation modules)
- `install/` - Contains all installation modules and scripts
- `install/packages.sh` - Installs 118+ packages via pacman
- `install/preflight/` - Pre-installation checks and environment setup
- `install/config/` - System configuration modules
- `bin/` - 84+ utility commands for managing OSVMarchi system
- `config/` - Default configuration files deployed to `~/.config/`
- `themes/` - Theme configurations for various color schemes

### Script Validation and Testing
```bash
# Validate all shell scripts syntax (takes ~1 second)
find . -name "*.sh" -type f -exec bash -n {} \;

# Check specific critical scripts
bash -n boot.sh
bash -n install.sh
bash -n install/packages.sh

# Validate file references exist
export OSVMARCHI_INSTALL=./install
test -f "$OSVMARCHI_INSTALL/packages.sh" && echo "packages.sh exists"
test -f "$OSVMARCHI_INSTALL/preflight/guard.sh" && echo "guard.sh exists"
```

### Installation Process and Timing
- **NEVER CANCEL** the installation process once started
- **Package Installation**: 15-20 minutes (118+ packages via pacman). NEVER CANCEL. Set timeout to 30+ minutes.
- **Configuration Deployment**: 5-10 minutes (36 config files + 47 default files)
- **Total Installation Time**: 20-30 minutes. NEVER CANCEL. Set timeout to 45+ minutes.
- **Post-installation Reboot**: Required (automatic after 5 seconds)

### Development Commands
```bash
# Clone and setup for development
git clone https://github.com/openSVM/osvmarchi.git ~/.local/share/osvmarchi
cd ~/.local/share/osvmarchi

# Add custom migration
osvmarchi-dev-add-migration

# Refresh specific configuration
osvmarchi-refresh-config hypr/hyprland.conf

# Update system
osvmarchi-update  # NEVER CANCEL: Takes 10-15 minutes

# System utilities
osvmarchi-version
osvmarchi-state
osvmarchi-theme-list
```

### Testing and Validation Scenarios
Since OSVMarchi is an Arch Linux installer, you CANNOT run the full installation on non-Arch systems. Instead, perform these validation tests:

#### Complete Validation Test Suite (ALWAYS run before making changes):
```bash
# 1. Script Syntax Validation (takes ~0.2 seconds)
find . -name "*.sh" -type f -exec bash -n {} \;
# Must complete with exit code 0 and no error output

# 2. Critical Scripts Validation
bash -n boot.sh && echo "boot.sh: OK"
bash -n install.sh && echo "install.sh: OK" 
bash -n install/packages.sh && echo "packages.sh: OK"

# 3. File Reference Validation
export OSVMARCHI_INSTALL=./install
test -f "$OSVMARCHI_INSTALL/packages.sh" && echo "packages.sh exists: OK"
test -f "$OSVMARCHI_INSTALL/preflight/guard.sh" && echo "guard.sh exists: OK"

# 4. Package Count Validation
pkg_count=$(grep -c "  [a-z]" install/packages.sh)
echo "Package count: $pkg_count"
[ "$pkg_count" -ge 118 ] && echo "Package count OK (≥118)"

# 5. Configuration Files Validation
config_count=$(find config -type f | wc -l)
default_count=$(find default -type f | wc -l)
echo "Config files: $config_count (should be 36+)"
echo "Default files: $default_count (should be 47+)"

# 6. Theme Validation
echo "Available themes: $(ls themes/ | wc -l) themes"
ls themes/

# 7. Utility Scripts Validation  
echo "Utility scripts: $(ls bin/osvmarchi-* | wc -l) commands"

# 8. Repository Maintenance
temp_files=$(find . -name "*.tmp" -o -name "*.bak" 2>/dev/null | wc -l)
echo "Temporary files: $temp_files (should be 0)"
```

#### Advanced File Reference Test:
```bash
# Check all sourced files exist in install.sh
grep "source.*OSVMARCHI_INSTALL" install.sh | while read -r line; do
  file=$(echo "$line" | sed 's/.*source \$OSVMARCHI_INSTALL\///; s/\.sh.*/\.sh/')
  test -f "install/$file" && echo "$file: OK" || echo "$file: MISSING"
done
```

### Common Operations

#### Working with Themes
```bash
# List available themes
ls themes/
# Themes include: catppuccin, gruvbox, nord, tokyo-night, everforest, etc.

# Theme files are organized as:
# themes/[theme-name]/[app].toml or .conf
```

#### Working with Configurations
```bash
# Configuration deployment pattern:
# ~/.local/share/osvmarchi/config/X/Y/Z -> ~/.config/X/Y/Z

# Key config locations:
# config/hypr/ - Hyprland window manager config
# config/alacritty/ - Terminal emulator config
# config/waybar/ - Status bar config
# config/nvim/ - Neovim editor config
```

#### Working with Utility Scripts
```bash
# All utility scripts are in bin/ and prefixed with "osvmarchi-"
ls bin/osvmarchi-*

# Key utilities:
# osvmarchi-update - System update (NEVER CANCEL: 10-15 minutes)
# osvmarchi-refresh-* - Refresh specific components
# osvmarchi-theme-* - Theme management
# osvmarchi-install-* - Install additional components
```

## Validation Requirements

### ALWAYS Validate Before Changes
1. Run script syntax validation: `find . -name "*.sh" -type f -exec bash -n {} \;`
2. Verify file references exist in installation scripts
3. Check package count remains reasonable (118+ packages)
4. Ensure no broken symbolic links or missing dependencies

### Manual Testing Requirements
Since you cannot run the actual installer:
1. Validate all bash script syntax (required)
2. Check file existence for all sourced scripts
3. Verify package lists are valid Arch packages
4. Test configuration file structure integrity
5. Confirm utility scripts have valid syntax

### Repository Maintenance
```bash
# Check for inconsistencies
find . -name "*.sh" -not -executable -exec chmod +x {} \;

# Verify no temporary files
find . -name "*.tmp" -o -name "*.bak" | wc -l  # Should be 0

# Check migrations directory
ls migrations/  # Should contain timestamp-based migration files
```

## Critical Warnings
- **NEVER** attempt to run `boot.sh` or `install.sh` on non-Arch systems
- **NEVER CANCEL** package installation or system updates once started
- **ALWAYS** set timeouts of 30+ minutes for package operations
- **ALWAYS** set timeouts of 45+ minutes for full installation
- Installation requires reboot and cannot be interrupted safely
- The system is designed for fresh Arch installations only

## File Structure Reference
```
├── boot.sh              # Initial installer download script
├── install.sh           # Main installation orchestrator  
├── install/
│   ├── packages.sh      # Package installation (118+ packages)
│   ├── preflight/       # Pre-installation validation
│   ├── config/          # System configuration modules
│   ├── packaging/       # Application-specific setup
│   └── login/           # Boot and login configuration
├── bin/                 # 84+ utility commands (osvmarchi-*)
├── config/              # Default configs (36+ files)
├── default/             # Additional defaults (47+ files)
├── themes/              # Color scheme configurations
└── migrations/          # Version migration scripts
```

This is a sophisticated Arch Linux customization system - treat it with appropriate care and always validate changes thoroughly before committing.