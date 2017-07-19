fpath=( "$HOME/.zfunctions" $fpath )
autoload -U promptinit; promptinit
prompt pure

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
export GHQ_ROOT=$HOME/.ghq

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
alias g='cd $(ghq root)/$(ghq list | peco)'


# beep を無効にする
setopt no_beep
# ディレクトリ名だけでcdする
setopt auto_cd
# 高機能なワイルドカード展開を使用する
setopt extended_glob

##----------------------------------------------------------------------------
## * 補完
##----------------------------------------------------------------------------
# 補完時に重複した文字を消す
setopt complete_in_word
# * で全ファイル補完をしない
setopt glob_complete

##----------------------------------------------------------------------------
## * コマンド履歴
##----------------------------------------------------------------------------
# 重複を記録しない
setopt hist_ignore_dups
# 開始と終了を記録
setopt EXTENDED_HISTORY
# historyを共有
setopt share_history
# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space
# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify
# 余分な空白は詰めて記録
setopt hist_reduce_blanks
# 古いコマンドと同じものは無視
setopt hist_save_no_dups
# historyコマンドは履歴に登録しない
setopt hist_no_store
# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

##----------------------------------------------------------------------------
## * 補完
##----------------------------------------------------------------------------
autoload -Uz compinit
compinit
# 小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

##----------------------------------------------------------------------------
## * cdr
##----------------------------------------------------------------------------
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# --------------
# plugin
# --------------
# zsh-syntax-highlighting
[ -f ${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source ${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f ${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source ${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# --------------
# peco
# --------------
function peco-select-history {
    BUFFER=`history -n -r 1 | peco --query "$LBUFFER"`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-cd () {
    local selected_dir=$(find ~/ -type d -name .git -prune -o -type d -print | peco)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-cd
bindkey '^x^f' peco-cd

function peco-cdr() {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-cdr
bindkey '^x^x' peco-cdr

function peco-buffer() {
    BUFFER=$(eval ${BUFFER} | peco)
    CURSOR=0
}

zle -N peco-buffer
bindkey "^[p" peco-buffer
