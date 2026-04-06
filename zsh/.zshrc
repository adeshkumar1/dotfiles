eval "$(starship init zsh)"

# antidote plugin manager config
[[ -r ~/.zsh/plugins/antidote/antidote.zsh ]] ||
    git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.zsh/plugins/antidote
source ~/.zsh/plugins/antidote/antidote.zsh

# plugins list, run 'rm ~/.zsh/plugins/plugins.txt' when you add plugins to refresh
# 'kind:defer' makes it so that plugins load do not block your shell
[[ -f ~/.zsh/plugins/plugins.txt ]] || cat <<EOF > ~/.zsh/plugins/plugins.txt
zsh-users/zsh-autosuggestions kind:defer
zsh-users/zsh-syntax-highlighting kind:defer
zsh-users/zsh-history-substring-search kind:defer
EOF

antidote load ~/.zsh/plugins/plugins.txt

export PATH="$PATH:$HOME/.local/bin"

alias gs="git status"
alias ga="git add ."
alias ls='eza --icons'
alias ll='eza -lh --git'
alias la='eza -lah'
alias leetcode='nvim leetcode.nvim'

source <(fzf --zsh)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
eval "$(zoxide init zsh)"

export GPG_TTY=$(tty)

# Source machine-specific config (work tools, secrets, managed blocks)
[ -f ~/.zsh_local ] && source ~/.zsh_local
