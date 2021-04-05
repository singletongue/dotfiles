" dein (https://github.com/Shougo/dein.vim)
if &compatible
    set nocompatible
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')

    call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
    call dein#add('Shougo/denite.nvim')
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('deoplete-plugins/deoplete-jedi')
    call dein#add('scrooloose/nerdtree')
    call dein#add('airblade/vim-gitgutter')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('chriskempson/base16-vim')
    call dein#add('sheerun/vim-polyglot')

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable
" end dein

" NERDTree
let NERDTreeShowHidden=1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>

" colorscheme and style
set termguicolors
colorscheme base16-onedark
let g:airline_theme='base16'
let g:airline#extensions#tabline#enabled = 1

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#show_docstring = 1
call deoplete#custom#source('jedi', 'rank', 1000)

" 改行時に自動でインデントを行う
set autoindent

" ファイルが外部で変更された際に自動で読み込む
set autoread

" バックスペースの影響範囲を設定する
set backspace=indent,eol,start

" 強調表示する列を設定する
set colorcolumn=80

" 未保存ファイルの終了時に保存確認を行なう
set confirm

" カーソル行を強調表示する
set cursorline

" 文字コードを設定する
set encoding=utf8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis

" タブの代わりにスペースを挿入する
set expandtab

" ファイル変更中に他のファイルを表示可能にする
set hidden

" コマンドラインモードで保存する履歴数を設定する
set history=10000

" 検索結果をハイライト表示する
set hlsearch

" 大文字と小文字を区別せず検索する
set ignorecase

" インクリメンタルサーチを有効にする
set incsearch

" ステータスバーを常に表示する
set laststatus=2

" 不可視文字を表示する
set list

" 不可視文字の表示方法を設定する
set listchars=eol:¬

" マウスを有効にする
set mouse=a

" ファイル上書き時にバックアップをとらない
set nobackup
set nowritebackup

" スワップファイルを作成しない
set noswapfile

" 行番号を表示する
set number

" ルーラーを表示する
set ruler

" カーソル行の上下へのオフセットを設定する
set scrolloff=5

" インデントでずれる幅を設定する
set shiftwidth=4

" 入力中のコマンドを表示する
set showcmd

" 対応するカッコを強調表示する
set showmatch

" タブバーを常に表示する
set showtabline=2

" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase

" 改行入力行の末尾にあわせてインデントを増減する
set smartindent

" コンテキストに応じたタブの処理を行なう
set smarttab

" タブやバックスペースで処理するスペースの数を設定する
set softtabstop=4

" 新しいウィンドウを下/右に開く
set splitbelow
set splitright

" タブ幅を設定する
set tabstop=4

" 編集中のファイル名を表示する
set title

" ビープを無効にする
set visualbell t_vb=

" 行頭・行末の左右移動で行を移動する
set whichwrap=b,s,h,l,<,>,[,]

" コマンドラインモードでの補完を有効にする
set wildmenu

" コマンドラインモードでの補完方法を設定する
set wildmode=list:longest,full

" 行を折り返さない
set nowrap

" 検索時に最後まで移動したら最初に戻る
set wrapscan

" 保存時に行末のスペースを削除する
autocmd BufWritePre * :%s/\s\+$//ge
