set laststatus=2

let g:lightline = {
  \ 'colorscheme': 'Tomorrow',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'fugitive', 'filename' ] ]
  \ },
	\ 'component': {
	\   'lineinfo': '⭡ %3l:%-2v',
	\ },
	\ 'component_function': {
	\   'readonly': 'MyReadonly',
	\   'fugitive': 'MyFugitive'
	\ },
	\ 'separator': { 'left': '⮀', 'right': '⮂' },
	\ 'subseparator': { 'left': '⮁', 'right': '⮃' }
	\ }
function! MyReadonly()
	return &readonly ? '⭤' : ''
endfunction
function! MyFugitive()
	return exists("*fugitive#head") && strlen(fugitive#head()) ? '⭠ '.fugitive#head() : ''
endfunction

