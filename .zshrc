# History Configuration
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history
setopt hist_reduce_blanks
setopt hist_verify
setopt extended_history

# Key Bindings
bindkey -e
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

# Enable and configure completion
autoload -Uz compinit
compinit -C

zstyle ':completion:*' completer _extensions _expand_alias _complete _approximate _ignored
zstyle ':completion:*' list-colors "no=00;37:fi=00;37:di=01;34:ln=01;36:pi=33:so=35:bd=33:cd=33:or=31:mi=05;37;41"
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
zstyle ':completion:*' file-patterns '%p(D):globbed-files *(D-/):directories' '*(D):all-files'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.cache/zsh/.zcompcache"
zstyle :compinstall filename "$HOME/.zshrc"

# Set Default Applications
if command -v helix &> /dev/null; then
    export EDITOR='helix'
fi
if command -v firefox-developer-edition &> /dev/null; then
    export BROWSER='firefox-developer-edition'
fi

# Custom Prompt
ZLE_RPROMPT_INDENT=0
eval "$(starship init zsh)"

# Aliases and Functions
alias co='wl-copy'
alias pa='wl-paste'
function sudo() { command sudo EDITOR=/usr/bin/helix "$@"; }
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias cat='bat'
alias code='/usr/bin/code --disable-gpu --password-store="gnome"'
alias df='duf'
alias du='dust'
alias htop='btm'
alias feh='feh --scale-down'
alias hx='helix'
alias files='joshuto'
alias ls='lsd'
alias l='lsd -la'
alias insights="$HOME/.flutter-bin/insights-client/insights_client"

# Custom Path
typeset -U path
path+=("$(go env GOBIN)")
path+=("$(go env GOPATH)/bin")
path+=("$HOME/.nix-profile/bin")
path+=("$HOME/.cargo/bin")
export PATH

# 1Password CLI
source /home/knowone/.config/op/plugins.sh

# Plugins
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

