#!/bin/bash
set -euo pipefail

DOTFILES_REPO="https://github.com/adeshkumar1/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

# Clone dotfiles if not already present
if [ ! -d "$DOTFILES_DIR" ]; then
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

# Install neovim
if ! command -v nvim &>/dev/null; then
  mkdir -p "$HOME/bin"
  curl -Lo "$HOME/bin/nvim" https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod +x "$HOME/bin/nvim"
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
