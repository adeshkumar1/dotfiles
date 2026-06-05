#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"
NVIM_VERSION="v0.11.0"

# Install neovim (arm64 tarball to /opt)
if ! command -v nvim &>/dev/null; then
  curl -fLo /tmp/nvim.tar.gz "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-arm64.tar.gz"
  sudo rm -rf /opt/nvim-linux-arm64
  sudo tar -C /opt -xzf /tmp/nvim.tar.gz
  rm /tmp/nvim.tar.gz
fi

# Install dependencies
sudo apt-get update -qq
sudo apt-get install -y -qq tmux stow ripgrep fd-find fzf unzip curl bat

# Stow nvim and tmux configs
cd "$DOTFILES_DIR"
stow --restow -t "$HOME" nvim
stow --restow -t "$HOME" tmux

# Install tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  GIT_CONFIG_NOSYSTEM=1 git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# Setup PATH
if ! grep -q 'nvim-linux-arm64' "$HOME/.bashrc" 2>/dev/null; then
  cat >> "$HOME/.bashrc" <<'BASHRC'

export PATH="/opt/nvim-linux-arm64/bin:$HOME/.local/share/nvim/mason/bin:$HOME/.local/share/gem/ruby/3.3.0/bin:/pay/src/go/bin:$HOME/go/bin:$PATH"
export EDITOR=nvim
BASHRC
fi

# Install ruby-lsp gem for Sorbet/Ruby LSP in Neovim
gem install ruby-lsp 2>/dev/null || true

# Install nvim plugins (may segfault on arm64, hence || true)
GIT_CONFIG_NOSYSTEM=1 /opt/nvim-linux-arm64/bin/nvim --headless "+Lazy! sync" +qa 2>/dev/null || true

echo "Done! nvim and tmux are ready."
