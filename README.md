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

Read more at [osvm.archi](http://osvm.archi).

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

OSVMarchi provides two methods for building custom ISO images:

#### Method 1: GitHub Actions (Cloud Building)

The ISO building process is automated via GitHub Actions:

1. Fork this repository
2. Modify the `.github/workflows/build-iso.yml` as needed
3. Push changes to trigger the build workflow
4. Download your custom ISOs from the workflow artifacts

#### Method 2: Local Building (Arch Linux)

For local building on Arch Linux systems, use the included build script:

```bash
# Clone the repository
git clone https://github.com/openSVM/osvmarchi.git
cd osvmarchi

# Build specific architecture
./build-iso.sh zen4

# Build all architectures
./build-iso.sh all

# Show help
./build-iso.sh --help
```

**Requirements for local building:**
- Arch Linux system (required)
- Non-root user with sudo access
- At least 5GB free disk space per ISO
- Internet connection for package downloads

See [docs/ISO_BUILDING.md](docs/ISO_BUILDING.md) for detailed documentation.

### Architecture Selection Guide

- **x86_64/amd64**: Universal compatibility, works on all 64-bit processors
- **Zen4**: Best performance on AMD Ryzen 7000 series and newer
- **Zen5**: Optimal for cutting-edge AMD Ryzen 9000 series
- **EPYC**: Server/workstation optimization for AMD EPYC processors
- **Threadripper**: High-end desktop optimization for AMD Threadripper

Choose the most specific architecture that matches your processor for optimal performance.

## Solana Development Environment

OSVMarchi includes a comprehensive Solana development environment with pre-installed tools and pinned versions for deterministic builds.

### Included Solana Tools

The following Solana development tools are installed automatically during OSVMarchi setup:

| Tool | Version | Description |
|------|---------|-------------|
| **Solana CLI** | v2.3.8 (latest) | Official Solana command-line interface |
| **OSVM** | latest | Solana Version Manager for switching between versions |
| **Anchor Framework** | v0.29.0 | Rust framework for Solana program development |
| **SPL Token CLI** | v4.0.0 | Command-line tools for SPL tokens |
| **SPL Associated Token Account CLI** | v3.0.2 | Tools for managing associated token accounts |
| **Sugar (Metaplex)** | v2.6.0 | Metaplex Candy Machine CLI for NFT projects |
| **Mollusk** | v0.1.0 | Solana program testing framework |

### Quick Start Commands

After installation, you can immediately start developing with Solana:

```bash
# Create a new wallet
solana-keygen new

# Start a local test validator
solana-test-validator

# Switch to a specific Solana version
osvm use 1.18.0

# Create a new Anchor project
anchor init my_solana_project

# Create a new SPL token
spl-token create-token

# Initialize a Candy Machine project
sugar create-config
```

### Manual Installation

If you need to install Solana tools on an existing OSVMarchi system:

```bash
# Install complete Solana development environment
osvmarchi-install-dev-env solana

# Or install just the Solana tools
osvmarchi-install-solana
```

### Version Management

All Solana tools are pinned to specific versions to ensure reproducible builds and compatibility. The Anchor Framework uses AVM (Anchor Version Manager) for easy version switching:

```bash
# List available Anchor versions
avm list

# Install and use a different Anchor version
avm install 0.30.0
avm use 0.30.0
```

## License

OSVMarchi is released under the [MIT License](https://opensource.org/licenses/MIT).

