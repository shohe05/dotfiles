##----------------------------------------------------------------------------
## * fzf
##----------------------------------------------------------------------------
# fzf初期化。入っていない場合はインストール
if [ -f ~/.fzf.zsh ]; then
  # agが入っていればagを使う
  which ag >/dev/null 2>&1
  if [ $? = 1 ]; then
    export FZF_DEFAULT_COMMAND='ag -g ""'
  fi
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
else
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf > /dev/null
  ~/.fzf/install > /dev/null
  export PATH=$PATH:~/.fzf/bin
  source ~/.zshrc
fi
