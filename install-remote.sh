#!/bin/bash
set -euo pipefail

DOTFILES_REPO="https://github.com/adeshkumar1/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

# Clone or pull latest dotfiles
if [ ! -d "$DOTFILES_DIR" ]; then
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
  git -C "$DOTFILES_DIR" pull --ff-only
fi

# Install neovim (arm64 tarball)
if ! nvim --version &>/dev/null; then
  rm -rf "$HOME/nvim"
  mkdir -p "$HOME/nvim"
  curl -fLo /tmp/nvim.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.tar.gz
  tar -xzf /tmp/nvim.tar.gz -C "$HOME/nvim" --strip-components=1
  rm /tmp/nvim.tar.gz
fi
export PATH="$HOME/nvim/bin:$PATH"

# Install dependencies
sudo apt-get update -qq
sudo apt-get install -y -qq tmux stow ripgrep fd-find unzip

# Stow nvim and tmux configs
cd "$DOTFILES_DIR"
stow -t "$HOME" nvim
stow -t "$HOME" tmux

# Install tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# Add nvim to PATH in bashrc if not already there
if ! grep -q 'nvim/bin' "$HOME/.bashrc" 2>/dev/null; then
  echo 'export PATH="$HOME/nvim/bin:$PATH"' >> "$HOME/.bashrc"
fi

# Plugins install automatically on first interactive launch via Lazy.nvim

echo "Done! nvim and tmux are ready."
