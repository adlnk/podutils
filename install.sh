#!/bin/bash

#######################################
# PodSync Installer
#
# Simple installer that copies podsync to ~/bin/ and makes it executable.
# Creates ~/bin/ directory if it doesn't exist.
#######################################

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_FILE="$SCRIPT_DIR/podsync"
INSTALL_DIR="$HOME/bin"
TARGET_FILE="$INSTALL_DIR/podsync"

echo "PodSync Installer"
echo "=================="

# Check if source file exists
if [[ ! -f "$SOURCE_FILE" ]]; then
    echo -e "${RED}Error: podsync script not found at $SOURCE_FILE${NC}"
    echo "Make sure you're running this installer from the correct directory."
    exit 1
fi

# Create install directory if it doesn't exist
if [[ ! -d "$INSTALL_DIR" ]]; then
    echo -e "${YELLOW}Creating directory: $INSTALL_DIR${NC}"
    mkdir -p "$INSTALL_DIR"
fi

# Copy the script
echo "Installing podsync to $TARGET_FILE"
cp "$SOURCE_FILE" "$TARGET_FILE"

# Make it executable
chmod +x "$TARGET_FILE"

echo -e "${GREEN}✓ Installation complete!${NC}"
echo ""
echo "Usage:"
echo "  podsync set-pod <pod-id>     # Set target pod"
echo "  podsync add <file>           # Add file to sync list"
echo "  podsync sync                 # Sync files"
echo "  podsync help                 # Show all commands"
echo ""

# Check if ~/bin is in PATH
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    echo -e "${YELLOW}Note: $HOME/bin is not in your PATH${NC}"
    echo "Add this line to your shell profile (~/.bashrc, ~/.zshrc, etc.):"
    echo ""
    echo "  export PATH=\"\$HOME/bin:\$PATH\""
    echo ""
    echo "Then restart your terminal or run: source ~/.bashrc"
    echo ""
    echo "Alternatively, you can run podsync using the full path:"
    echo "  $TARGET_FILE help"
else
    echo -e "${GREEN}✓ $HOME/bin is already in your PATH${NC}"
    echo "You can now use 'podsync' from anywhere!"
fi

echo ""
echo "Get started:"
echo "  cd /path/to/your/project"
echo "  podsync set-pod your-pod-id"
echo "  podsync add script.py"
echo "  podsync sync"