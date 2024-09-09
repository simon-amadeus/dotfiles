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

#
# Set Default Applications
#
# Editor
if command -v helix &> /dev/null; then
    export EDITOR='helix'
fi

# Browser
if command -v firefox-developer-edition &> /dev/null; then
    export BROWSER='firefox-developer-edition'
fi

# Custom prompt
ZLE_RPROMPT_INDENT=0
eval "$(starship init zsh)"


#
# Custom Aliases
#
# Wl-clipboard
alias co='wl-copy'
alias pa='wl-paste'

# Allow aliases with sudo
alias sudo='sudo EDITOR=/usr/bin/helix '

# .dotfiles
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# bat (cat alternative)
alias cat='bat'

# Fix vscode lagging
alias code='/usr/bin/code --disable-gpu --password-store="gnome"'

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
alias l='lsd -la'

# Insights Client
alias insights="$HOME/.flutter-bin/insights-client/insights_client"

#
## Custom Path
#
# Go
export PATH="$PATH$( [ -n "$(go env GOBIN)" ] && echo ":$(go env GOBIN)" ):$(go env GOPATH)/bin"
# Nix
export PATH="$PATH:$HOME/.nix-profile/bin"
# Rust
export PATH="$PATH:$HOME/.cargo/bin"

#
## 1Password CLI
#
source /home/knowone/.config/op/plugins.sh

#
## Place add the end
#
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

