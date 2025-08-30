# OSVMarchi ISO Building

This document describes the automated ISO building process for OSVMarchi.

## Overview

The GitHub Actions workflow in `.github/workflows/build-iso.yml` automatically builds bootable ISO images containing OSVMarchi pre-configured for different AMD processor architectures.

## Architecture Matrix

The workflow builds ISOs for the following architectures:

| Matrix Entry | Architecture | GCC March | GCC Mtune | Target Processors |
|--------------|-------------|-----------|-----------|------------------|
| `x86_64` | Generic x86_64 | `x86-64` | `generic` | All 64-bit processors |
| `amd64` | AMD64 baseline | `x86-64` | `generic` | All AMD 64-bit processors |
| `zen4` | Zen4 optimized | `znver4` | `znver4` | AMD Ryzen 7000 series, EPYC Genoa |
| `zen5` | Zen5 optimized | `znver5` | `znver5` | AMD Ryzen 9000 series, EPYC Turin |
| `epyc` | EPYC optimized | `znver2` | `znver2` | AMD EPYC Rome/Milan server processors |
| `threadripper` | Threadripper optimized | `znver3` | `znver3` | AMD Threadripper PRO/WX series |

## Build Process

1. **Environment Setup**: Ubuntu runner with Docker, QEMU, and archiso tools
2. **Base ISO Creation**: Clone archiso profile and customize for OSVMarchi
3. **Package Integration**: Include OSVMarchi dependencies and core packages
4. **Architecture Optimization**: Apply GCC flags specific to target architecture
5. **OSVMarchi Integration**: Embed OSVMarchi installer and auto-setup scripts
6. **ISO Building**: Use `mkarchiso` to create bootable ISO image
7. **Artifact Upload**: Store ISOs with checksums as workflow artifacts

## Key Features

- **Automated Builds**: Triggered on push/PR to main branch
- **Architecture Optimization**: Each ISO is compiled with architecture-specific flags
- **Pre-configured**: OSVMarchi is embedded and ready to install
- **Checksums**: SHA256 and MD5 checksums for verification
- **Caching**: Docker layer caching for faster builds
- **Error Handling**: Comprehensive error checking and logging

## Build Artifacts

Each successful build produces:
- `osvmarchi-{arch}-{date}.iso` - Bootable ISO image
- `osvmarchi-{arch}-{date}.iso.sha256` - SHA256 checksum
- `osvmarchi-{arch}-{date}.iso.md5` - MD5 checksum

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