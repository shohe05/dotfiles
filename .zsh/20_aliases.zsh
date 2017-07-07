##----------------------------------------------------------------------------
## * エイリアス
##----------------------------------------------------------------------------
alias emacs='emacsclient -nw -a ""'
alias e='emacs'
alias ekill='emacsclient -e "(kill-emacs)"'
alias fig='docker-compose'
alias gst='git status'
alias ls='ls -G'
alias ll='ls -lh'
alias la='ls -ahl'
alias less='less -MiR'
alias cp='cp -iv'
alias rm='rm -iv'
alias mv='mv -iv'
alias cl='clear'
alias vi='vim'
alias grep='grep --color'
alias g='cd $(ghq root)/$(ghq list | fzf)'
