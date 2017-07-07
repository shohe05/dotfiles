for f in ~/.zsh/[0-9]*.(sh|zsh)
do
  source "$f"
done

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
