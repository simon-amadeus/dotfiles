#
## History Configuration
#
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history
setopt hist_reduce_blanks
setopt hist_verify
setopt extended_history


#
## Key Bindings
#
bindkey -e
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward


#
## Enable and configure completion
#
autoload -Uz compinit
mkdir -p "$HOME/.cache/zsh"
compinit -C -d "$HOME/.cache/zsh/zcompdump"

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


#
## Custom Prompt
#
ZLE_RPROMPT_INDENT=0
eval "$(starship init zsh)"


#
## Aliases and Functions
#
if command -v bat &>/dev/null; then
    alias cat='bat'
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi
command -v btm &>/dev/null && alias htop='btm'
command -v git &>/dev/null && alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
command -v duf &>/dev/null && alias df='duf'
command -v dust &>/dev/null && alias du='dust'
command -v feh &>/dev/null && alias feh='feh --scale-down'
command -v helix &>/dev/null && alias hx='helix'
command -v joshuto &>/dev/null && alias files='joshuto'
command -v lsd &>/dev/null && alias ls='lsd'
command -v lsd &>/dev/null && alias l='lsd -la'
command -v wl-copy &>/dev/null && alias co='wl-copy'
command -v wl-paste &>/dev/null && alias pa='wl-paste'

function sudo() { command sudo ${EDITOR:+EDITOR="$EDITOR"} "$@"; }


#
## Custom Path
#
typeset -U path
path=(${path:#""})
if command -v go &>/dev/null; then
    path+=("$(go env GOPATH)/bin")
fi
[[ -d "$HOME/.nix-profile/bin" ]] && path+=("$HOME/.nix-profile/bin")
[[ -d "$HOME/.cargo/bin" ]] && path+=("$HOME/.cargo/bin")
export PATH


#
## 1Password CLI
#
[[ -f $HOME/.config/op/plugins.sh ]] && source $HOME/.config/op/plugins.sh


#
## ZSH Plugins
#
load_plugin() {
    local plugin=$1
    if [[ -f /usr/share/zsh/plugins/$plugin/$plugin.zsh ]]; then
        source /usr/share/zsh/plugins/$plugin/$plugin.zsh
    else
        echo "Error: Plugin $plugin not found" >&2
    fi
}

load_plugin zsh-autosuggestions
load_plugin zsh-syntax-highlighting
