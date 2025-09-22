# OSVMarchi ISO Building

This document describes how to build bootable Arch Linux ISO images with OSVMarchi pre-installed for different CPU architectures.

## Overview

OSVMarchi provides two methods for building ISO images:

1. **GitHub Actions Workflow** - Automated building in the cloud
2. **Local Build Script** - Manual building on your Arch Linux system

Both methods create bootable ISO images based on vanilla Arch Linux with OSVMarchi pre-configured and optimized for specific AMD processor architectures.

## Architecture Support

The following architectures are supported with their specific optimizations:

| Architecture | Name | Target Processors | GCC Flags |
|-------------|------|------------------|-----------|
| `x86_64` | generic-x86_64 | All 64-bit processors | `-march=x86-64 -mtune=generic` |
| `amd64` | amd64 | AMD64 baseline | `-march=x86-64 -mtune=generic` |
| `zen4` | zen4-optimized | AMD Ryzen 7000, EPYC Genoa | `-march=znver4 -mtune=znver4` |
| `zen5` | zen5-optimized | AMD Ryzen 9000, EPYC Turin | `-march=znver5 -mtune=znver5` |
| `epyc` | epyc-optimized | AMD EPYC Rome/Milan | `-march=znver2 -mtune=znver2` |
| `threadripper` | threadripper-optimized | AMD Threadripper PRO/WX | `-march=znver3 -mtune=znver3` |

## Method 1: GitHub Actions Workflow

The GitHub Actions workflow automatically builds ISOs for all architectures on every push/PR to the main branch.

### Workflow Features

- **Automated Building**: Builds all 6 architecture variants automatically
- **Matrix Strategy**: Parallel builds for faster completion
- **Error Handling**: Comprehensive validation and error checking
- **Artifact Storage**: ISOs stored for 30 days with checksums
- **Docker Caching**: Optimized build times with layer caching

### Build Process

1. **Environment Setup**: Ubuntu runner with Docker, QEMU, and archiso tools
2. **Base ISO Creation**: Clone archiso profile and customize for OSVMarchi
3. **Package Integration**: Include OSVMarchi dependencies and core packages
4. **Architecture Optimization**: Apply GCC flags specific to target architecture
5. **OSVMarchi Integration**: Embed OSVMarchi installer and auto-setup scripts
6. **ISO Building**: Use `mkarchiso` to create bootable ISO image
7. **Artifact Upload**: Store ISOs with checksums as workflow artifacts

### Triggering Builds

The workflow runs automatically on:
- Push to `main` or `master` branch
- Pull requests to `main` or `master` branch
- Manual trigger via GitHub Actions web interface

### Accessing Built ISOs

1. Go to the [Actions tab](https://github.com/openSVM/osvmarchi/actions)
2. Click on a successful workflow run
3. Download ISO artifacts from the "Artifacts" section
4. Each architecture has its own artifact with ISO, SHA256, and MD5 files

## Method 2: Local Build Script

For developers who want to build ISOs locally on their Arch Linux system.

### Requirements

- **Arch Linux** (required - will not work on other distributions)
- **Non-root user** (script will use sudo when needed)
- **Internet connection** (for downloading packages and archiso)
- **Free disk space** (at least 5GB per ISO)

### Installation

The build script is included in the repository:

```bash
# Clone the repository
git clone https://github.com/openSVM/osvmarchi.git
cd osvmarchi

# The script is ready to use
./build-iso.sh --help
```

### Usage

#### Basic Usage

```bash
# Build generic x86_64 ISO (default)
./build-iso.sh

# Build specific architecture
./build-iso.sh zen4
./build-iso.sh zen5
./build-iso.sh epyc

# Build all architectures
./build-iso.sh all
```

#### Advanced Options

```bash
# Build with cleanup after
./build-iso.sh --cleanup zen4

# Enable verbose output
./build-iso.sh --verbose zen5

# Show help
./build-iso.sh --help
```

### Local Build Process

The script performs these steps for each architecture:

1. **Dependency Installation**: Installs archiso and required tools
2. **Environment Setup**: Creates build directories and clones archiso configs
3. **Package Configuration**: Creates custom package list with OSVMarchi dependencies
4. **OSVMarchi Integration**: Embeds OSVMarchi installer and configurations
5. **Architecture Optimization**: Applies CPU-specific compiler flags
6. **Profile Customization**: Updates ISO metadata and branding
7. **ISO Building**: Uses `mkarchiso` to create the bootable image
8. **Checksum Generation**: Creates SHA256 and MD5 verification files

### Build Output

Each successful build produces:

- **ISO Image**: `osvmarchi-{name}-{date}.iso`
- **SHA256 Checksum**: `osvmarchi-{name}-{date}.iso.sha256`
- **MD5 Checksum**: `osvmarchi-{name}-{date}.iso.md5`

Files are saved in the `iso-build/` directory by default.

## ISO Contents

Each built ISO contains:

### Base System
- Vanilla Arch Linux base system
- Linux kernel and firmware
- Essential system tools and utilities

### OSVMarchi Components
- Complete OSVMarchi installation files
- Pre-configured for target architecture
- Automatic installer service
- Development tools and dependencies

### Architecture Optimizations
- CPU-specific compiler flags in `/etc/makepkg.conf`
- Optimized package building configuration
- Performance tuning for target processors

### Boot and Installation
- UEFI and BIOS boot support
- OSVMarchi auto-installer available as `osvmarchi-install`
- Network connectivity and SSH access
- Live environment with development tools

## Usage After Building

### Booting the ISO

1. Write the ISO to a USB drive or DVD
2. Boot from the media
3. The system will start with OSVMarchi branding
4. Network connectivity will be automatically configured

### Installing OSVMarchi

Once booted into the live environment:

```bash
# Start the OSVMarchi installation with GUI partitioning
osvmarchi-install
```

This will run the complete OSVMarchi installation process with:
- Interactive disk selection
- Automatic UEFI partitioning or manual GParted GUI
- Base Arch Linux system installation
- Full OSVMarchi configuration deployment
- Bootloader setup and system configuration

The installer can handle any disk format and provides both automatic and manual partitioning options.

### Architecture Verification

To verify you're using the correct architecture-optimized ISO:

```bash
# Check the ISO version and architecture
cat /etc/osvmarchi-version

# Check compiler optimization flags
cat /etc/makepkg.conf | grep CFLAGS
```

## Key Features

- **Automated Builds**: Triggered on push/PR to main branch (GitHub Actions)
- **Local Building**: Standalone script for Arch Linux systems
- **Architecture Optimization**: Each ISO is compiled with architecture-specific flags
- **Pre-configured**: OSVMarchi is embedded and ready to install
- **Checksums**: SHA256 and MD5 checksums for verification
- **Caching**: Docker layer caching for faster builds (GitHub Actions)
- **Error Handling**: Comprehensive error checking and logging

## Build Artifacts

Each successful build produces:
- `osvmarchi-{arch}-{date}.iso` - Bootable ISO image
- `osvmarchi-{arch}-{date}.iso.sha256` - SHA256 checksum
- `osvmarchi-{arch}-{date}.iso.md5` - MD5 checksum

## Troubleshooting

### Common Issues

**Build fails with "command not found"**
- Ensure you're running on Arch Linux
- Check that archiso is properly installed
- Run with `--verbose` for detailed output

**"profiledef.sh not found" error**
- Network connectivity issue preventing archiso clone
- Try running the script again
- Check internet connection

**Insufficient disk space**
- Each ISO requires ~2-5GB of build space
- Clean up previous builds or use `--cleanup` option
- Monitor disk space with `df -h`

**Permission errors**
- Don't run the script as root
- Ensure user has sudo privileges
- Check file permissions in build directory

### Getting Help

For build issues:

1. Run with `--verbose` flag for detailed output
2. Check the build logs in `iso-build/archiso-{arch}/build.log`
3. Verify system requirements are met
4. Check GitHub Actions workflow for reference implementation

## Customization

To customize the build process:

1. **Modify Package List**: Edit the `packages.x86_64` section in the workflow
2. **Change Compiler Flags**: Update the `makepkg.conf` generation step
3. **Add Services**: Modify the systemd service configuration
4. **Custom Scripts**: Add additional scripts to the `airootfs` structure

## Troubleshooting

### Build Failures

If builds fail:

1. Check the workflow logs for specific error messages
2. Build logs are uploaded as artifacts for failed builds
3. Common issues:
   - Missing packages in the package list
   - Invalid compiler flags for target architecture
   - Insufficient disk space
   - Network timeouts during package downloads

### Architecture Support

All architectures are x86_64 variants with different optimizations:
- Zen4/Zen5 require GCC 11+ for znver4/znver5 support
- EPYC optimizations focus on server workloads
- Threadripper optimizations balance high-core-count performance

### Testing ISOs

To test built ISOs:

1. Download from workflow artifacts
2. Verify checksums
3. Test in VM (QEMU/VirtualBox/VMware)
4. Test on physical hardware matching target architecture

## Dependencies

The workflow requires:
- Ubuntu runner with sudo access
- Docker and QEMU for cross-architecture support
- archiso tools for ISO building
- Sufficient disk space (~10GB per architecture)
- Network access for package downloads

## Security Considerations

- ISOs are built in isolated environments
- No persistent state between builds
- All dependencies downloaded from official repositories
- Checksums provided for integrity verification