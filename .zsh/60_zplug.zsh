##----------------------------------------------------------------------------
## * zplug
##----------------------------------------------------------------------------
if [ ! -f ~/.zplug/bin/zplug-env ]; then
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi
source ~/.zplug/init.zsh

zplug "junegunn/fzf"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "mollifier/anyframe"
zplug "motemen/ghq", \
    as:command, \
    from:gh-r, \
    rename-to:ghq

if ! zplug check --verbose; then
  printf "Install? [y/N]:"
  if read -q; then
    echo; zplug install
  fi
fi
zplug load --verbose >/dev/null
