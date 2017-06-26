
call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'dracula/vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rhysd/accelerated-jk'
Plug 'posva/vim-vue'
call plug#end()
" nerdtree
map <Space>n :NERDTreeToggle<CR>
" tab
nnoremap <C-l> gt
nnoremap <C-h> gT
" One Darkを有効にするために必要
let g:onedark_termcolors=16
" シンタックスを入れる
syntax on
" カラースキーマを宣言する
set t_Co=256
colorscheme dracula
" ファイルタイプを入れる
filetype plugin indent on
" 検索モードを開く
nmap <Space>f :CtrlP<CR>
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" j/kによる移動を速くする
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

" ==================================================
" 基本設定
" ==================================================

" 行番号を表示する
set number

" viminfoに情報を入れとく
" set viminfo=string

" 保存されてないファイルがあっても別のファイル開ける
set hidden

set cursorline
hi clear CursorLine
highlight CursorLine ctermbg=Black
" highlight CursorLine ctermfg=Black
" ビープ音じゃなくてビジュアルベルを使う
set vb t_vb=

" vimの外でファイルが変更された時に自動で読み込む
set autoread

" ファイル名を出す
set title

" カーソル移動
set whichwrap=b,s,h,l,<,>,[,]

" BSをどこでも使えるように
set backspace=indent,eol,start

" ディレクトリもvimで開く
set browsedir=buffer

" ステータスライン
" ステータス行を常に表示する
set laststatus=2

" ステータスラインの内容を設定
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

" 最後に実行したコマンドを表示する
set showcmd

" 補完の候補をリスト表示
set wildmode=list,full

" コマンドモードで補完の候補を表示
set wildmenu

" 仮想編集。文字のない場所にもカーソルが当たる
set virtualedit=onemore

" 編集するファイル内にvimの設定を書ける
set modelines

" 対応するカッコが光る
set showmatch " 対応するカッコが光る

" 現在のモードを表示する
set showmode

" カーソルの位置を表示
set ruler

" カーソルの上下に最低表示する行数
set scrolloff=5

" クリップボードを使う
set clipboard=unnamed,autoselect

" 日本語でアルファベットの倍の幅を使う
if exists('&ambiwidth')
  set ambiwidth=double
endif

" splitとvsplitを使う
" splitで下に出す
set splitbelow

" vsplitで右に出す
set splitright

" スペース、タブ関連
" tabをスペース4つに設定
set tabstop=4

" tabを押すとスペース4つを入力
set softtabstop=4

" インデントをスペース4つに設定
set shiftwidth=4

" tab、<、>、入力時にインデントをする
set expandtab

" BS時にshiftwidth分のスペースを消す
set smarttab

" インデント
" 改行時に、カレント行のインデントをコピー
set autoindent

" プログラミング言語を自動インデント
set smartindent

" 検索
" 検索結果をハイライト
set hlsearch

" インクリメンタルサーチ
set incsearch

" 大文字小文字を区別しない
set ignorecase

" 大文字と小文字が混ざった時だけ区別する
set smartcase

" ファイルの最後まで検索したら上に戻らない
set nowrapscan

" エンコード
" vim内で使うエンコード
set encoding=utf-8

" 既存のファイルを読むエンコード
set fileencodings=utf8

" ターミナルのエンコード
set termencoding=utf-8

" ハイライトを設定する
highlight Pmenu ctermbg=4

" swpファイルの場所を指定
set directory-=.

" バックアップの設定
set backup
set backupdir=/tmp

" 不可視文字を可視化
set list
set lcs=tab:>-,trail:_,extends:>,precedes:<,nbsp:x


" 自動で入力されるコメントを削除
autocmd Filetype * set formatoptions-=ro

" これやらないと矩形ビジュアルモードで反映されない
inoremap <C-c> <Esc>

" カッコまわり
inoremap }} {}<Left><CR><ESC>O
inoremap { {}<Left>
inoremap )) ()<Left><CR><ESC>O
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap <> <><Left>
inoremap '' ''<Left>
inoremap " ""<Left>

" 記号のショートカット
"
" tabで補完
inoremap <Tab> <C-x><C-o>

" insert mode
imap <C-p> <Up>
imap <C-n> <Down>
imap <C-b> <Left>
imap <C-f> <Right>
imap <C-a> <C-o>:call <SID>home()<CR>
imap <C-e> <End>
imap <C-d> <Del>
imap <C-h> <BS>
imap <C-k> <C-r>=<SID>kill()<CR>

function! s:home()
  let start_column = col('.')
  normal! ^
  if col('.') == start_column
  ¦ normal! 0
  endif
  return ''
endfunction

function! s:kill()
  let [text_before, text_after] = s:split_line()
  if len(text_after) == 0
  ¦ normal! J
  else
  ¦ call setline(line('.'), text_before)
  endif
  return ''
endfunction

function! s:split_line()
  let line_text = getline(line('.'))
  let text_after  = line_text[col('.')-1 :]
  let text_before = (col('.') > 1) ? line_text[: col('.')-2] : ''
  return [text_before, text_after]
endfunction
