set nocompatible
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'taglist.vim'
NeoBundle 'skk.vim'
NeoBundle 'vim-scala'

filetype plugin indent on


let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_quick_match = 1
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'scala' : $HOME.'/.vim/bundle/vim-scala/dict/scala.dict',
    \ }



syntax on

set incsearch
set ignorecase
set smartcase

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set clipboard=unnamed

"skk.vim ####################################
let skk_jisyo = '~/.skk-jisyo'
let skk_large_jisyo = '~/Library/Application Support/AquaSKK/SKK-JISYO.L'
let skk_auto_save_jisyo = 1
let skk_keep_state = 0
let skk_egg_like_newline = 1
let skk_show_annotation = 1
let skk_use_face = 1

"powerline ######################################
set laststatus=2 " Always show the statusline

