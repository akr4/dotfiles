set nocompatible
filetype plugin indent off
set encoding=utf-8

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
"NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'taglist.vim'
NeoBundle 'skk.vim'
NeoBundle 'vim-scala'
NeoBundle 'altercation/vim-colors-solarized.git'
"NeoBundle 'project.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'jiangmiao/simple-javascript-indenter'
NeoBundle 'jelera/vim-javascript-syntax'

NeoBundle 'nono/jquery.vim'
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery

NeoBundle 'teramako/jscomplete-vim'
autocmd FileType javascript :setl omnifunc=jscomplete#CompleteJS

NeoBundle 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

NeoBundle 'scrooloose/nerdtree'
map <C-t> :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<CR>

" Rust
au BufRead,BufNewFile *.rs setfiletype rust

filetype plugin indent on

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

"skk.vim ####################################
let skk_jisyo = '~/.skk-jisyo'
let skk_large_jisyo = '~/Library/Application Support/AquaSKK/SKK-JISYO.L'
let skk_auto_save_jisyo = 1
let skk_keep_state = 0
let skk_egg_like_newline = 1
let skk_show_annotation = 1
let skk_use_face = 1

"indent guides #################################
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 2

"tags #########################################
set tags=.tags,~/.tags

"template #####################################
autocmd BufNewFile *.hs 0r $HOME/.vim/template/haskell.hs

"golang #######################################
if $GOROOT != ''
  set rtp+=$GOROOT/misc/vim
endif
au BufRead,BufNewFile *.go set filetype=go
