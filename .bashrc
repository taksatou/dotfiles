# for production
export PS1="\e[41m\u@\h [\$(date +%k:%M:%S)]$\e[0m "

# for stg
# export PS1="\e[43m\e[30m\u@\h [\$(date +%k:%M:%S)]$\e[0m "

# bind "\C-p":history-search-backward
# bind "\C-n":history-search-forward

HISTSIZE=1000000
HISTFILESIZE=2000000

alias ls='ls --color'
