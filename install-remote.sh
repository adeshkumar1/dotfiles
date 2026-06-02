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
if ! command -v nvim &>/dev/null && [ ! -f "$HOME/bin/nvim" ]; then
  mkdir -p "$HOME/bin"
  curl -Lo /tmp/nvim.tar.gz -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.tar.gz
  tar -xzf /tmp/nvim.tar.gz -C "$HOME/bin" --strip-components=1
  rm /tmp/nvim.tar.gz
fi
export PATH="$HOME/bin:$PATH"

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

# Install neovim plugins
nvim --headless "+Lazy! sync" +qa 2>/dev/null || true

echo "Done! nvim and tmux are ready."
