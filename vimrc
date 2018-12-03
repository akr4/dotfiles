set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'nathanaelkane/vim-indent-guides'
call vundle#end()
filetype plugin indent on


set encoding=utf-8

" Rust
au BufRead,BufNewFile *.rs setfiletype rust

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_quick_match = 1
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'scala' : $HOME.'/.vim/bundle/vim-scala/dict/scala.dict',
    \ }



set incsearch
set ignorecase
set smartcase

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set clipboard=unnamed
set modeline
set modelines=5
set noshowmode
set ruler

syntax enable
source $HOME/.vim/colors.vim
source $HOME/.vim/statusline.vim
"source $HOME/.vim/tab.vim
"source $HOME/.vim/lightline.vim

autocmd BufWritePre * :%s/\s\+$//ge
"autocmd BufWritePre * :%s/\t/  /ge

nmap <Space>b :ls<CR>:buffer
nmap <Space>f :edit .<CR>
nmap <Space>v :vsplit<CR><C-w><C-w>:ls<CR>:buffer
nmap <Space>V :Vexplore!<CR><CR>

" commands
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

source $HOME/.vim/unite.vim

"indent guides #################################
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 2

"tags #########################################
set tags=.tags,~/.tags

"python #######################################
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=4 expandtab shiftwidth=4 softtabstop=4

"template #####################################
autocmd BufNewFile *.hs 0r $HOME/.vim/template/haskell.hs

"golang #######################################
if $GOROOT != ''
  set rtp+=$GOROOT/misc/vim
endif
au BufRead,BufNewFile *.go set filetype=go
