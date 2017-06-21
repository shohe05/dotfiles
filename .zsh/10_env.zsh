if is_linux ; then
  PROMPT='%F{blue}%n@%M%f %F{cyan}
%~%f `git-current-branch`%f'
else
  PROMPT='%F{cyan}%~%f `git-current-branch`'
fi

##----------------------------------------------------------------------------
## * コマンド履歴
##----------------------------------------------------------------------------
# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zhistory
# メモリに保存される履歴の件数
export HISTSIZE=10000
# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000000

##----------------------------------------------------------------------------
## * その他
##----------------------------------------------------------------------------
# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
export ZPLUG_HOME=~/.zplug

# export EDITOR=vim
