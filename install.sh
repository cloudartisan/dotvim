#!/bin/bash
#
# Dotvim Installation Script
# Installs vim configuration, creates symlinks, and installs plugins
#

set -e

DOTVIM_DIR="$(pwd)"
HOME_VIM_DIR="$HOME/.vim"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo "=== DotVim Installation ==="
echo "Installing from: $DOTVIM_DIR"

# Function to print status messages
print_status() {
  if [ $1 -eq 0 ]; then
    echo -e "${GREEN}SUCCESS${NC}: $2"
  elif [ $1 -eq 1 ]; then
    echo -e "${RED}ERROR${NC}: $2"
    if [ -n "$3" ]; then
      echo -e "${YELLOW}Details: $3${NC}"
    fi
    exit 1
  else
    echo -e "${YELLOW}WARNING${NC}: $2"
  fi
}

# Check if we're in the dotvim directory
if [ ! -f "$DOTVIM_DIR/vimrc" ]; then
  print_status 1 "vimrc not found in current directory" "Please run this script from the dotvim repository root"
fi

# Step 1: Create ~/.vim directory if it doesn't exist
echo -e "\n=> Setting up vim directory"
if [ ! -d "$HOME_VIM_DIR" ]; then
  mkdir -p "$HOME_VIM_DIR"
  print_status 0 "Created vim directory at $HOME_VIM_DIR"
else
  if [ "$DOTVIM_DIR" != "$HOME_VIM_DIR" ]; then
    print_status 2 "Vim directory already exists at $HOME_VIM_DIR" "Will update contents but not delete existing files"
  fi
fi

# Step 2: Create symlinks if running from a different directory
if [ "$DOTVIM_DIR" != "$HOME_VIM_DIR" ]; then
  echo -e "\n=> Creating symlinks"
  
  # Copy or symlink vimrc
  if [ -L "$HOME_VIM_DIR/vimrc" ]; then
    rm "$HOME_VIM_DIR/vimrc"
  fi
  
  ln -sf "$DOTVIM_DIR/vimrc" "$HOME_VIM_DIR/vimrc"
  print_status 0 "Created symlink for vimrc"
  
  # Create symlinks to ~/.vimrc and ~/.gvimrc
  ln -sf "$HOME_VIM_DIR/vimrc" "$HOME/.vimrc"
  print_status 0 "Created symlink for .vimrc"
  
  ln -sf "$HOME_VIM_DIR/vimrc" "$HOME/.gvimrc"
  print_status 0 "Created symlink for .gvimrc"
  
  # Create necessary directories
  for dir in UltiSnips bundle; do
    if [ ! -d "$HOME_VIM_DIR/$dir" ]; then
      mkdir -p "$HOME_VIM_DIR/$dir"
      print_status 0 "Created directory: $HOME_VIM_DIR/$dir"
    fi
  done
  
  # Copy UltiSnips if they exist
  if [ -d "$DOTVIM_DIR/UltiSnips" ]; then
    cp -r "$DOTVIM_DIR/UltiSnips"/* "$HOME_VIM_DIR/UltiSnips/"
    print_status 0 "Copied UltiSnips to $HOME_VIM_DIR/UltiSnips"
  fi
else
  print_status 0 "Already in ~/.vim directory, no symlinks needed"
fi

# Step 3: Install vim-plug if not already installed
echo -e "\n=> Setting up vim-plug"
if [ ! -f "$HOME_VIM_DIR/autoload/plug.vim" ]; then
  mkdir -p "$HOME_VIM_DIR/autoload"
  # Use curl but provide fallback message if it fails
  echo "Downloading vim-plug (you may be prompted for curl options)..."
  if command -v curl &> /dev/null; then
    curl -fLo "$HOME_VIM_DIR/autoload/plug.vim" --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
      && print_status 0 "Installed vim-plug" \
      || print_status 2 "Failed to download vim-plug automatically" "Please download manually from https://github.com/junegunn/vim-plug"
  else
    print_status 2 "curl not found" "Please install vim-plug manually from https://github.com/junegunn/vim-plug"
  fi
else
  print_status 0 "vim-plug already installed"
fi

# Step 4: Install plugins
echo -e "\n=> Installing vim plugins"
if [ -f "$HOME_VIM_DIR/autoload/plug.vim" ]; then
  echo "This may take a while..."
  # Use a silent install to avoid user interaction
  vim -E -s -u "$HOME_VIM_DIR/vimrc" +PlugInstall +qall > /dev/null 2>&1 || {
    # If silent install fails, try interactive install
    echo "Silent installation failed, trying interactive mode..."
    vim +PlugInstall +qall
  }
  print_status 0 "Plugins installed successfully"
else
  print_status 2 "Skipping plugin installation" "vim-plug is not installed"
fi

# Step 5: Verify installation with test script
echo -e "\n=> Verifying installation"
if [ -f "$DOTVIM_DIR/test_vimrc.sh" ]; then
  bash "$DOTVIM_DIR/test_vimrc.sh"
else
  print_status 2 "Test script not found" "Skipping verification"
fi

echo -e "\n=== Installation Complete ==="
echo "Your vim configuration has been installed successfully!"
echo "Start using it by running: vim"
