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


[ -f ~/.zshrc.include ] && source ~/.zshrc.include

#alias grep="grep -n"
alias l='ls'
alias e='emacs -nw'
alias sc='screen -r -RR'
alias ri='ri --format ansi'
alias grepl='grep --line-buffered'
alias ssh='ssh -o ServerAliveInterval=60'

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
    builtin cd $* && ls
}

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
