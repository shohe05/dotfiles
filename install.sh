#!/bin/sh
#cf. http://orgachem.hatenablog.com/entry/2014/05/13/001100
#    http://qiita.com/b4b4r07/items/b70178e021bef12cd4a2
set -e
DOTFILES_DIR="${HOME}/dotfiles"

symlink() {
  ln -fs "$1" "$2"
}

for f in ${DOTFILES_DIR}/.??*
do
  f=${f##*/}
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue
  [ -e "$HOME/$f" ] && cp "$HOME/$f" "$HOME/${f}.bk"
  symlink "$DOTFILES_DIR/$f" "$HOME/$f"
  echo $f symlink completed!
done