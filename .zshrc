# Created by newuser for 4.3.6

if [ -e ~/.zsh.d ]; then
    fpath=(~/.zsh.d $fpath)
    autoload -U ~/.zsh.d/*(:t)
fi;

autoload -U compinit
compinit

autoload colors
colors

bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

## Command history configuration
HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=100000000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data


export PAGER='lv -c'
export EDITOR='vim'
export RI='--format ansi'

# auto directory pushd that you can get dirs list by cd -[tab]
setopt auto_pushd

# command correct edition before each completion attempt
#setopt correct

# compacked complete list display
setopt list_packed

# no beep sound when complete list displayed
setopt nolistbeep

#alias grep="grep -n"
alias l='ls'
alias e='emacs -nw'
alias sc='screen -r -RR'
alias ri='ri --format ansi'
alias grepl='grep --line-buffered'
alias ssh='ssh -o ServerAliveInterval=60'
alias pj="ruby -rjson -e 'puts JSON.pretty_generate(JSON.parse(ARGF.read))'"
alias py="ruby -ryaml -r pp -e 'pp YAML.load(ARGF.read)'"

case ${OSTYPE} in
    darwin*)
        alias ls="ls -G"
        ;;
    linux*)
        alias ls="ls --color=auto"
esac

export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'

#alias tr='tree -L 2'

function tmr() {
    if [ `tmux list-sessions | grep -v attached | wc -l` = 0 ]; then
	tmux -u;
    else
	tmux attach
    fi
}

function jman() {
    LC_ALL=ja_JP.UTF8 man $*
}

function sudo() {
    echo "[38;5;200m"
    /usr/bin/sudo $*
    echo "return: $?"
    echo "[m"
}

function cd() {
    if [ -z "$*" ]; then
        builtin cd ~/ && ls
    else
        builtin cd "$*" && ls
    fi
}

function dam() {
    open dash://$*
}


## --peco
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^[r' peco-select-history

## --peco


if [ $EMACS ]; then unsetopt zle; fi

### vcs info
# http://d.hatena.ne.jp/mollifier/20090814/p1
autoload -Uz vcs_info
#zstyle ':vcs_info:*' enable svn hg git bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}


if [ -d $HOME/.rbenv ]; then
    export PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH
    eval "$(rbenv init - zsh)"
fi

[ -f ~/.zshrc.include ] && source ~/.zshrc.include


## 重複パスをけす
typeset -U path cdpath fpath manpath

echo -ne "\e]1;`hostname | awk -F'.' '{print $1}'`\a"
alias cp="cp -p"

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
# [[ -s "/home/takayuki/.gvm/bin/gvm-init.sh" ]] && source "/home/takayuki/.gvm/bin/gvm-init.sh"
