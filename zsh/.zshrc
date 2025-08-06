# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
#
# source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
#
# # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/adesh/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/adesh/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/adesh/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/adesh/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="/usr/local/opt/python@3.10/bin:$PATH"

export PATH=$PATH:/Users/adesh/.spicetify
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
alias spotify='bash <(curl -sSL https://spotx-official.github.io/run.sh)'
alias gs='git status'

eval "$(starship init zsh)"
