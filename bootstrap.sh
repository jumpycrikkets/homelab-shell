#!/bin/bash
set -euo pipefail

# ============================================================================
# Bootstrap Script - System Setup
# ============================================================================

FAILED=()

# ============================================================================
# Functions
# ============================================================================

install_pkg() {
    local pkg=$1
    
    if dpkg -l 2>/dev/null | grep -q "^ii  $pkg"; then
        echo "  ✓ $pkg already installed"
        return 0
    fi
    
    echo "  → Installing $pkg..."
    if sudo apt install "$pkg" -y &>/dev/null; then
        echo "  ✓ $pkg installed"
        return 0
    else
        echo "  ✗ Failed to install $pkg"
        FAILED+=("$pkg")
        return 1
    fi
}

install_with_fallback() {
    local primary=$1 fallback=$2
    
    if dpkg -l 2>/dev/null | grep -q "^ii  $primary"; then
        echo "  ✓ $primary already installed"
        return 0
    fi
    
    if dpkg -l 2>/dev/null | grep -q "^ii  $fallback"; then
        echo "  ✓ $fallback already installed"
        return 0
    fi
    
    echo "  → Trying $primary..."
    if sudo apt install "$primary" -y &>/dev/null; then
        echo "  ✓ $primary installed"
        return 0
    fi
    
    echo "  → Trying $fallback..."
    if sudo apt install "$fallback" -y &>/dev/null; then
        echo "  ✓ $fallback installed"
        return 0
    fi
    
    echo "  ✗ Failed to install $primary or $fallback"
    FAILED+=("$primary/$fallback")
    return 1
}

# ============================================================================
# Main
# ============================================================================

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "System Bootstrap"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "Updating system..."
if sudo apt update -y &>/dev/null && sudo apt upgrade -y &>/dev/null; then
    echo "  ✓ System updated"
else
    echo "  ✗ System update failed"
fi
echo ""

echo "Installing packages..."
packages=(
    "curl"
    "wget"
    "git"
    "tilix"
    "fish"
    "btop"
)

for pkg in "${packages[@]}"; do
    install_pkg "$pkg"
done

install_with_fallback "neofetch" "fastfetch"
echo ""

# ============================================================================
# Summary
# ============================================================================

if [ ${#FAILED[@]} -eq 0 ]; then
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "✓ Bootstrap complete!"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    exit 0
else
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "⚠ Bootstrap completed with errors"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Failed packages:"
    printf '  - %s\n' "${FAILED[@]}"
    echo ""
    exit 1
fi
