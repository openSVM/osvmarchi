# OSVMarchi

[![Build ISO Images](https://github.com/openSVM/osvmarchi/actions/workflows/build-iso.yml/badge.svg)](https://github.com/openSVM/osvmarchi/actions/workflows/build-iso.yml)

Turn a fresh Arch installation into a fully-configured, beautiful, and modern solana and web development system based on Hyprland by running a single command. OSVMarchi is an opinionated take on what Solana user Linux can be at its best.

████████████████████████████████████████████████████████████████
█▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐█
█▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐█
█▌▒▒▒▒▒▒███████▒▒▒▒▒█████████▒▒█████▒▒▒█████▒██████▒▒▒██████▒▒▐█
█▌▒▒▒▒███░░░░░███▒▒███░░░░░███░░███▒▒▒░░███▒░░██████▒██████▒▒▒▐█
█▌▒▒▒███▒▒▒▒▒░░███░███▒▒▒▒░░░▒▒░███▒▒▒▒░███▒▒░███░█████░███▒▒▒▐█
█▌▒▒░███▒▒▒▒▒▒░███░░█████████▒▒░███▒▒▒▒░███▒▒░███░░███▒░███▒▒▒▐█
█▌▒▒░███▒▒▒▒▒▒░███▒░░░░░░░░███▒░░███▒▒▒███▒▒▒░███▒░░░▒▒░███▒▒▒▐█
█▌▒▒░░███▒▒▒▒▒███▒▒███▒▒▒▒░███▒▒░░░█████░▒▒▒▒░███▒▒▒▒▒▒░███▒▒▒▐█
█▌▒▒▒░░░███████░▒▒░░█████████▒▒▒▒▒░░███▒▒▒▒▒▒█████▒▒▒▒▒█████▒▒▐█
█▌▒▒▒▒▒░░░░░░░▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒░░░▒▒▒▒▒▒░░░░░▒▒▒▒▒░░░░░▒▒▒▐█
█▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█████▒▒▒▒▒▒▒███▒▒▒▒▒▒▒▒▒▒▐█
█▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░███▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▐█
█▌▒▒▒▒▒▒▒██████▒▒▒████████▒▒▒██████▒▒░███████▒▒▒████▒▒▒▒▒▒▒▒▒▒▐█
█▌▒▒▒▒▒▒░░░░░███▒░░███░░███▒███░░███▒░███░░███▒░░███▒▒▒▒▒▒▒▒▒▒▐█
█▌▒▒▒▒▒▒▒███████▒▒░███▒░░░▒░███▒░░░▒▒░███▒░███▒▒░███▒▒▒▒▒▒▒▒▒▒▐█
█▌▒▒▒▒▒▒███░░███▒▒░███▒▒▒▒▒░███▒▒███▒░███▒░███▒▒░███▒▒▒▒▒▒▒▒▒▒▐█
█▌▒▒▒██░░████████▒█████▒▒▒▒░░██████▒▒████▒█████▒█████▒▒▒▒▒▒▒▒▒▐█
█▌▒▒░░▒▒░░░░░░░░▒░░░░░▒▒▒▒▒▒░░░░░░▒▒░░░░▒░░░░░▒░░░░░▒▒▒▒▒▒▒▒▒▒▐█
█▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐█
█▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐█
████████████████████████████████████████████████████████████████

Read more at [osvm.archi](https://osvm.archi).

## ISO Images

OSVMarchi provides pre-built ISO images optimized for different AMD processor architectures. These bootable ISO images contain OSVMarchi pre-configured and ready to install.

### Available Architectures

| Architecture | Optimization | Target Processors |
|-------------|-------------|------------------|
| **x86_64** | Generic x86_64 | All 64-bit processors |
| **amd64** | AMD64 baseline | All AMD 64-bit processors |
| **Zen4** | Zen4 optimized (-march=znver4) | AMD Ryzen 7000 series, EPYC Genoa |
| **Zen5** | Zen5 optimized (-march=znver5) | AMD Ryzen 9000 series, EPYC Turin |
| **EPYC** | EPYC optimized (-march=znver2) | AMD EPYC Rome/Milan server processors |
| **Threadripper** | Threadripper optimized (-march=znver3) | AMD Threadripper PRO/WX series |

### Downloading ISO Images

ISO images are automatically built on every push to the main branch and are available as workflow artifacts:

1. Go to the [Actions tab](https://github.com/openSVM/osvmarchi/actions/workflows/build-iso.yml)
2. Click on the latest successful workflow run
3. Download the ISO for your target architecture from the artifacts section

Each ISO includes:
- SHA256 and MD5 checksums for verification
- Architecture-specific compiler optimizations
- OSVMarchi pre-installed and ready to configure

### Using the ISOs

1. **Download** the appropriate ISO for your processor architecture
2. **Verify** the download using the provided checksums
3. **Create** a bootable USB drive using tools like `dd`, Rufus, or Balena Etcher
4. **Boot** from the USB drive
5. **Run** `osvmarchi-install` to begin the installation process

### Building Custom ISOs

The ISO building process is automated via GitHub Actions. To build custom ISOs:

1. Fork this repository
2. Modify the `.github/workflows/build-iso.yml` as needed
3. Push changes to trigger the build workflow
4. Download your custom ISOs from the workflow artifacts

### Architecture Selection Guide

- **x86_64/amd64**: Universal compatibility, works on all 64-bit processors
- **Zen4**: Best performance on AMD Ryzen 7000 series and newer
- **Zen5**: Optimal for cutting-edge AMD Ryzen 9000 series
- **EPYC**: Server/workstation optimization for AMD EPYC processors
- **Threadripper**: High-end desktop optimization for AMD Threadripper

Choose the most specific architecture that matches your processor for optimal performance.

## License

OSVMarchi is released under the [MIT License](https://opensource.org/licenses/MIT).

