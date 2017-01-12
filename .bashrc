# プロンプト
PS1="\[\e[1;34m\]\w\[\e[m\] "

export PROMPT_DIRTRIM=2
export PATH=$PATH:~/bin

# alias
alias emacs='emacsclient -nw -a ""'
alias e='emacs'
alias ekill='emacsclient -e "(kill-emacs)"'
alias fig='docker-compose'
alias g='git'
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
alias a='atom .'
alias grep='grep --color'
alias ytd='youtube-dl -o "%(title)s.%(ext)s"'
alias ytdmp3='youtube-dl -o "%(title)s.%(ext)s" -x --audio-format mp3'
alias diary='emacs ~/diary/$(date "+%Y/%m/%d.md")'

# fzf初期化。入っていない場合はインストール
if [ -f ~/.fzf.bash ]; then
  # agが入っていればagを使う
  if which ag > /dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='ag -g ""'
  fi
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash
else
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf > /dev/null
  ~/.fzf/install > /dev/null
  # ~/.fzf/bin にインストールしている場合はパスを通す
  [ -f ~/.fzf/bin/fzf ] && export PATH=$PATH:~/.fzf/bin
  source ~/.bashrc
fi

# pyenv
if which pyenv > /dev/null 2>&1; then
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# rbenv
if which rbenv > /dev/null 2>&1; then
  export PATH="$RBENV_ROOT/bin:$PATH"
  eval "$(rbenv init -)"
fi

# gtags with pygments
export GTAGSLABEL=pygments
