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
if command -v helix &> /dev/null; then
    export EDITOR='helix'
fi

# Custom prompt
ZLE_RPROMPT_INDENT=0
eval "$(starship init zsh)"

# Oh-my-zsh
source ~/.oh-my-zshrc


#
# Custom Aliases
#
# Allow aliases with sudo
alias sudo='sudo '

# .dotfiles
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# bat (cat alternative)
alias cat='bat'

# Fix vscode lagging
alias code='/usr/bin/code --disable-gpu'

# duf (df alternative)
alias df='duf'

# dust (du alternative)
alias du='dust'

# bottom (htop alternative)
alias htop='btm'

# feh (image viewer)
alias feh='feh --scale-down'

# helix (editor)
alias hx='helix'

# joshuto (file manager)
alias files='joshuto'

# lsd (ls alternative)
alias ls='lsd'

# Insights Client
alias insights="$HOME/.flutter-bin/insights-client/insights_client"

#
## Custom Path
#
# Flutter
export PATH="$PATH:/opt/flutter/bin"
# Go
export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"

#
## 1Password CLI
#
source /home/knowone/.config/op/plugins.sh
