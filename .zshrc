# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000
bindkey -e
# End of lines configured by zsh-newuser-install

# Include hidden files in substring completion
#setopt globdots

# The following lines were added by compinstall
zstyle ':completion:*' completer _extensions _expand_alias _complete _approximate _ignored
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
zstyle ':completion:*' file-patterns '%p(D):globbed-files *(D-/):directories' '*(D):all-files'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.cache/zsh/.zcompcache"
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Set default editor
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nvim'
else
    export EDITOR='vim'
fi

# Custom prompt
ZLE_RPROMPT_INDENT=0
eval "$(starship init zsh)"

# Oh-my-zsh
source ~/.oh-my-zshrc

# NVM
source /usr/share/nvm/init-nvm.sh

#
# Custom Aliases
#
# .dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Fix vscode lagging
alias code='/usr/bin/code --disable-gpu'

# Helix Editor
alias hx='helix'

#
## Custom Path
#
# Flutter
export PATH="$PATH:/opt/flutter/bin"
# Yarn
export PATH="$PATH:$(yarn global bin)"

