#!/bin/bash
set -u  # Exit if undefined variable

FAILED_PACKAGES=()

install_package() {
    local package=$1
    
    # Check if already installed
    if dpkg -l 2>/dev/null | grep -q "^ii  $package"; then
        echo "✓ $package is already installed"
        return 0
    fi
    
    echo "→ Installing $package..."
    if sudo apt install "$package" -y &>/dev/null; then
        echo "✓ $package installed successfully"
        return 0
    else
        echo "✗ Failed to install $package"
        FAILED_PACKAGES+=("$package")
        return 1
    fi
}

install_system_info_tool() {
    # Check if neofetch already installed
    if dpkg -l 2>/dev/null | grep -q "^ii  neofetch"; then
        echo "✓ neofetch is already installed"
        return 0
    fi
    
    # Check if fastfetch already installed
    if dpkg -l 2>/dev/null | grep -q "^ii  fastfetch"; then
        echo "✓ fastfetch is already installed"
        return 0
    fi
    
    # Try neofetch first
    echo "→ Installing neofetch..."
    if sudo apt install neofetch -y &>/dev/null; then
        echo "✓ neofetch installed successfully"
        return 0
    fi
    
    # Fall back to fastfetch
    echo "→ neofetch unavailable, installing fastfetch as fallback..."
    if sudo apt install fastfetch -y &>/dev/null; then
        echo "✓ fastfetch installed successfully"
        return 0
    else
        echo "✗ Failed to install neofetch or fastfetch"
        FAILED_PACKAGES+=("neofetch/fastfetch")
        return 1
    fi
}

echo "Starting utility installation..."
echo

install_package "tilix"
install_package "fish"
install_system_info_tool
install_package "btop"

echo
if [ ${#FAILED_PACKAGES[@]} -eq 0 ]; then
    echo "✓ All utilities installed successfully!"
    exit 0
else
    echo "⚠ Installation complete with errors. Failed packages:"
    printf '  - %s\n' "${FAILED_PACKAGES[@]}"
    exit 1
fi
