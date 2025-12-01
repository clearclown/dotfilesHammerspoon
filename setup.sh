#!/bin/bash
# =============================================================================
# dotfilesHammerspoon Setup Script
# =============================================================================

set -e

echo "🔧 Setting up Hammerspoon & Karabiner-Elements..."

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# -----------------------------------------------------------------------------
# 1. Install Hammerspoon
# -----------------------------------------------------------------------------
echo -e "\n${YELLOW}[1/4] Installing Hammerspoon...${NC}"
if brew list --cask hammerspoon &>/dev/null; then
    echo -e "${GREEN}✓ Hammerspoon already installed${NC}"
else
    brew install --cask hammerspoon
    echo -e "${GREEN}✓ Hammerspoon installed${NC}"
fi

# -----------------------------------------------------------------------------
# 2. Install Karabiner-Elements
# -----------------------------------------------------------------------------
echo -e "\n${YELLOW}[2/4] Installing Karabiner-Elements...${NC}"
if brew list --cask karabiner-elements &>/dev/null; then
    echo -e "${GREEN}✓ Karabiner-Elements already installed${NC}"
else
    brew install --cask karabiner-elements
    echo -e "${GREEN}✓ Karabiner-Elements installed${NC}"
fi

# -----------------------------------------------------------------------------
# 3. Create symlinks
# -----------------------------------------------------------------------------
echo -e "\n${YELLOW}[3/4] Creating symlinks...${NC}"

# Hammerspoon
if [ -L ~/.hammerspoon ]; then
    rm ~/.hammerspoon
elif [ -d ~/.hammerspoon ]; then
    echo -e "${YELLOW}Backing up existing ~/.hammerspoon to ~/.hammerspoon.bak${NC}"
    mv ~/.hammerspoon ~/.hammerspoon.bak
fi
ln -sf ~/dotfilesHammerspoon ~/.hammerspoon
echo -e "${GREEN}✓ ~/.hammerspoon -> ~/dotfilesHammerspoon${NC}"

# Karabiner
KARABINER_CONFIG_DIR=~/.config/karabiner
if [ ! -d "$KARABINER_CONFIG_DIR" ]; then
    mkdir -p "$KARABINER_CONFIG_DIR"
fi

if [ -L "$KARABINER_CONFIG_DIR/karabiner.json" ]; then
    rm "$KARABINER_CONFIG_DIR/karabiner.json"
elif [ -f "$KARABINER_CONFIG_DIR/karabiner.json" ]; then
    echo -e "${YELLOW}Backing up existing karabiner.json${NC}"
    mv "$KARABINER_CONFIG_DIR/karabiner.json" "$KARABINER_CONFIG_DIR/karabiner.json.bak"
fi
ln -sf ~/dotfilesHammerspoon/karabiner/karabiner.json "$KARABINER_CONFIG_DIR/karabiner.json"
echo -e "${GREEN}✓ Karabiner config linked${NC}"

# -----------------------------------------------------------------------------
# 4. Launch applications
# -----------------------------------------------------------------------------
echo -e "\n${YELLOW}[4/4] Launching applications...${NC}"
open -a "Hammerspoon"
open -a "Karabiner-Elements"
echo -e "${GREEN}✓ Applications launched${NC}"

# -----------------------------------------------------------------------------
# Post-setup instructions
# -----------------------------------------------------------------------------
echo -e "\n${GREEN}=============================================${NC}"
echo -e "${GREEN}✓ Setup complete!${NC}"
echo -e "${GREEN}=============================================${NC}"
echo ""
echo -e "${YELLOW}Required permissions (System Settings > Privacy & Security):${NC}"
echo "  1. Accessibility → Add Hammerspoon & Karabiner-Elements"
echo "  2. Input Monitoring → Add Hammerspoon & Karabiner-Elements"
echo ""
echo -e "${YELLOW}Vimium (browser extension):${NC}"
echo "  Arc/Chrome: https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb"
echo "  Firefox:    https://addons.mozilla.org/en-US/firefox/addon/vimium-ff/"
echo ""
echo -e "${YELLOW}Keybindings:${NC}"
echo "  Caps Lock        → Hyper (Ctrl+Alt+Cmd)"
echo "  Caps Lock alone  → Escape"
echo "  Hyper + /        → Show all keybindings"
echo ""
