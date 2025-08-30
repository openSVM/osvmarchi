# Omarchy - Arch Linux Distribution Installer
Omarchy is a comprehensive shell script-based system that transforms a fresh Arch Linux installation into a fully-configured, modern web development environment using Hyprland. The system includes 84 utility commands, 118 migration scripts, and extensive configuration modules.

**Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.**

## Prerequisites and Environment Requirements
**CRITICAL**: This system ONLY works on Vanilla Arch Linux with pacman package manager. Do not attempt to run on other distributions.

### System Requirements Check
Run these validation steps before any development work:
```bash
# Check if running on Arch Linux (REQUIRED)
[[ -f /etc/arch-release ]] || echo "ERROR: Requires Vanilla Arch Linux"

# Verify not running as root (REQUIRED) 
[ "$EUID" -eq 0 ] && echo "ERROR: Must not run as root"

# Check architecture (REQUIRED)
[ "$(uname -m)" != "x86_64" ] && echo "ERROR: Requires x86_64 CPU"

# Verify clean Arch installation
pacman -Qe gnome-shell &>/dev/null && echo "ERROR: Remove GNOME first"
pacman -Qe plasma-desktop &>/dev/null && echo "ERROR: Remove KDE first"
```

## Working Effectively

### Initial Repository Setup and Validation
```bash
# Clone the repository and set up environment
git clone https://github.com/openSVM/osvmarchy.git
cd osvmarchy
export PATH="$PWD/bin:$PATH"
export OMARCHY_PATH="$PWD"

# ALWAYS validate shell scripts before making changes
shellcheck boot.sh install.sh  # Takes 1 second - warnings expected
shellcheck bin/omarchy-*       # Takes 1 second - validates all 84 commands

# Check repository structure (instant)
find . -name "*.sh" | wc -l    # Should show ~160+ shell scripts
ls bin/ | wc -l                # Should show 84 utility commands
ls migrations/ | wc -l         # Should show 118+ migration scripts
```

### Main Installation Flow (NEVER RUN IN PRODUCTION)
**WARNING**: The main installation process is destructive and designed for fresh Arch systems only.

```bash
# Boot script downloads and installs from basecamp/omarchy by default
# NEVER CANCEL: Full installation takes 45-90 minutes depending on internet speed
# Set timeout to 120+ minutes for any installation command
./boot.sh  # Clones basecamp/omarchy and runs install.sh

# Installation phases:
# 1. Package installation (install/packages.sh) - 121 packages via pacman
# 2. Configuration (16 config modules in install/config/)  
# 3. Hardware setup (install/config/hardware/)
# 4. Login setup (Plymouth, bootloader config)
# 5. Migration execution (118+ migration scripts)
```

### Development Environment Setup
Install development tools using the omarchy-install-dev-env command:

```bash
# NEVER CANCEL: Development environment installation can take 10-30 minutes
# Set timeout to 45+ minutes for development environment commands

# Available environments (all require mise package manager):
omarchy-install-dev-env ruby      # Installs Ruby on Rails
omarchy-install-dev-env node      # Installs Node.js LTS 
omarchy-install-dev-env python    # Installs Python + uv package manager
omarchy-install-dev-env go        # Installs Go latest
omarchy-install-dev-env rust      # Installs Rust via rustup (downloads from internet)
omarchy-install-dev-env java      # Installs Java latest
omarchy-install-dev-env php       # Installs PHP + Composer
omarchy-install-dev-env elixir    # Installs Erlang + Elixir

# These require internet connectivity:
# - Rust: Downloads from https://sh.rustup.rs
# - Python: Downloads uv from https://astral.sh/uv/install.sh  
# - OCaml: Downloads from https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh
```

### System Management Commands
After installation, use these commands to manage the system:

```bash
# Version and update management
omarchy-version              # Show current version from git tags
omarchy-update-available     # Check for updates from GitHub
omarchy-update               # Update system (creates snapshot first)
omarchy-migrate              # Run pending migrations

# Package management
omarchy-pkg-install <pkg>    # Install package via pacman
omarchy-pkg-remove <pkg>     # Remove package
omarchy-pkg-aur-install <pkg> # Install AUR package

# Theme management  
omarchy-theme-list           # List available themes
omarchy-theme-set <theme>    # Set theme (11 themes available)
omarchy-theme-update         # Update current theme

# System configuration refresh
omarchy-refresh-hyprland     # Refresh Hyprland config
omarchy-refresh-waybar       # Refresh Waybar config
omarchy-refresh-hypridle     # Refresh idle management
```

## Validation and Testing

### Code Quality Validation
**ALWAYS** run these validation steps before committing any changes:

```bash
# Shell script validation (takes 1-2 seconds, may show warnings but catches errors)
shellcheck boot.sh install.sh                    # Main scripts - warnings expected
find . -name "*.sh" -exec shellcheck {} \;       # All shell scripts - warnings expected  
find bin/ -name "omarchy-*" -exec shellcheck {} \; # All utility commands - warnings expected

# Repository integrity checks (instant)
git status --porcelain                            # Check for uncommitted changes
wc -l $(find . -name "*.sh" | head -50)         # Verify script integrity
```

### Manual Validation Scenarios
**CRITICAL**: After making changes, always test these scenarios:

#### 1. Command Validation Scenario
```bash
# Test utility command help/usage (instant)
omarchy-install-dev-env                    # Should show usage message
omarchy-version 2>/dev/null || echo "OK"  # Version check
export PATH="$PWD/bin:$PATH" && which omarchy-update # Command availability

# Test command parsing (instant) 
bash -n bin/omarchy-*                      # Syntax check all commands
```

#### 2. Configuration File Validation
```bash
# Verify config file integrity (instant)
ls config/ | wc -l                        # Should show ~21 config directories
ls install/config/ | wc -l                # Should show 16 config modules
ls install/packaging/ | wc -l             # Should show 6 packaging modules

# Test config loading simulation
grep -r "source.*config" install.sh       # Show config loading pattern
```

#### 3. Migration System Validation  
```bash
# Check migration system (instant)
ls migrations/ | wc -l                    # Should show 118+ migrations
head -5 migrations/*.sh                   # Sample migration content
ls migrations/ | sort -n | tail -5       # Most recent migrations
```

### Timing Expectations and Timeouts
**NEVER CANCEL** these operations - they require substantial time:

- **Full Installation**: 45-90 minutes (set timeout: 120+ minutes)
- **Package Installation**: 20-45 minutes for 121 packages (set timeout: 60+ minutes) 
- **Development Environment Setup**: 10-30 minutes per language (set timeout: 45+ minutes)
- **Git Clone Operations**: 30-120 seconds for large repos (set timeout: 300+ seconds)
- **Shell Script Validation**: 1-2 seconds for all scripts
- **Config Refresh Operations**: 5-15 seconds each
- **Migration Execution**: 2-10 minutes depending on number pending

## Common Development Tasks

### Adding New Utility Commands
```bash
# Create new command in bin/ directory
touch bin/omarchy-my-new-command
chmod +x bin/omarchy-my-new-command

# Add shebang and basic structure
echo '#!/bin/bash' > bin/omarchy-my-new-command

# Validate immediately
shellcheck bin/omarchy-my-new-command
```

### Adding Configuration Modules
```bash
# Configuration modules go in install/config/
touch install/config/my-config.sh
chmod +x install/config/my-config.sh

# Add to install.sh sourcing section
echo 'source $OMARCHY_INSTALL/config/my-config.sh' >> install.sh
```

### Adding Migrations
```bash
# Use the migration helper (creates timestamped migration)
omarchy-dev-add-migration "Description of migration"

# Manually create migration (use Unix timestamp)
touch migrations/$(date +%s).sh
echo 'echo "Migration description"' > migrations/$(date +%s).sh
```

## Repository Structure Reference
```
osvmarchy/
├── boot.sh                 # Main entry point (downloads and runs installer)
├── install.sh              # Main installation script (sources all modules)
├── bin/                    # 84 utility commands for system management
├── install/                # Installation modules
│   ├── config/            # 16 system configuration modules  
│   ├── packaging/         # 6 package installation modules
│   ├── preflight/         # 7 pre-installation check modules
│   └── packages.sh        # 121 packages to install via pacman
├── migrations/            # 118+ migration scripts for updates
├── config/                # Default configuration files for applications
├── themes/                # 11 visual themes for the system
└── applications/          # Desktop application definitions
```

## Important URLs and Dependencies
The system downloads components from these URLs (verify connectivity):
- Main repository: https://github.com/basecamp/omarchy.git
- Rust installer: https://sh.rustup.rs  
- Python uv installer: https://astral.sh/uv/install.sh
- OCaml installer: https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh
- LazyVim starter: https://github.com/LazyVim/starter

## Error Patterns and Troubleshooting
Common issues and solutions:

```bash
# "pacman: command not found" - Not running on Arch Linux
[[ -f /etc/arch-release ]] || echo "SOLUTION: Use Arch Linux"

# "gum: command not found" - Package not installed
sudo pacman -S gum  # Install gum for UI components

# "mise: command not found" - Development environment tool missing  
# SOLUTION: Run full installation first or install mise manually

# Permission errors
# SOLUTION: Ensure not running as root, use regular user account
```

## Critical Reminders
- **NEVER CANCEL** any installation, package, or development environment commands
- **ALWAYS** set timeouts of 60+ minutes for build/install operations  
- **ALWAYS** set timeouts of 45+ minutes for development environment setup
- **ONLY** run on Vanilla Arch Linux - will fail on other distributions
- **ALWAYS** validate shell scripts with shellcheck before committing
- **NEVER** run the main installation (./boot.sh) on a production system
- **ALWAYS** test command syntax with `bash -n` before execution