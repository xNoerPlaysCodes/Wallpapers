# export PS1=$(echo -e "\n[change .zshrc]\n> ")

# -- My zshrc! --

function loadJava {
    export JAVA_HOME=$HOME/.jre/zulu/$1/bin
    if [[ "$1" == "" ]]; then
        echo "Fallback Java 21"
        loadJava 21
        return
    fi

    export PATH=$JAVA_HOME:$PATH
}

function reload {
    source ~/.zshrc
}

function reloadq {
    export __MY_ZSHRC__QUIET=1
    reload
}

function reloadqns {
    clear
}

function reloadns {
    clear
    fastfetch
}

function cmake {
    command cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON "$@"
}

function __myzshrc_passprovider {
    local password_name=$1
    local password=$2

    local user_password="itsmenoer" # !!!! REPLACE THIS !!!!

    echo -n "[$1] password for $USER: "
    read -s enter_password
    if [[ "$user_password" == "$enter_password" ]]; then
        echo
        echo "press [ENTER] to view"
        read
        clear
        echo "> $password"
        echo
        echo "press [ENTER] when done"
        read
        clear
    else
        echo
        echo "incorrect password"
    fi
}

function gitpass {
    __myzshrc_passprovider "git" "nuh uh"
}

if [[ "$__MY_ZSHRC__QUIET" != "1" ]]; then
    reloadns
fi

loadJava 21

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# -- Binds --
bindkey -e
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[Z' autosuggest-accept
bindkey '^[[3~' delete-char
bindkey "^H" backward-kill-word
# -----------

# -- Shell Plugins --
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-syntax-highlighting
# -------------------

# -- Shell Options --
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY
# -------------------

# -- Env --
export CC=clang
export CXX=clang++
export CMAKE_GENERATOR="Ninja"
export PATH=$PATH:/home/noerlol/.scripts
# ---------

# -- Aliases --
alias editrc='nvim ~/.zshrc; reload'
alias e='exit'
alias yays='yay -S'
alias yaysr='yay --search'
alias pacs='sudo pacman -S'
alias pacsr='sudo pacman -Ss'
alias ls='ls --color=auto -F'
alias du='du -h'
alias cd..='cd ..'
alias gv='kitten icat'
alias dmesg='sudo dmesg'
# -------------

# -- OMP (Last Line) --
eval "$(oh-my-posh init zsh -c /home/noerlol/.config/ohmyposh/tokyonight_storm.json)"
# ---------------------
