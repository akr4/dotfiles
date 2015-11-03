" unite.vim ####################################
nmap <Space>o :Unite file_rec -buffer-name=files<CR>
nmap <Space>O :UniteWithBufferDir file_rec -buffer-name=files<CR>
nmap <Space>u :Unite file_mru<CR>
nmap <Space>U :UniteWithCurrentDir file_mru<CR>
nmap <Space>s :Unite buffer file_rec -buffer-name=files -input=**/**.scala<CR>
nmap <Space>S :UniteWithCurrentDir file_rec -buffer-name=files -input=src/**/**.scala<CR>
nmap <Space>j :Unite buffer file_rec -buffer-name=files -input=app/**/**.js<CR>

nnoremap <C-p> :Unite file_rec/async<cr>
nnoremap <Space>/ :Unite grep:.<CR>
nnoremap <space>s :Unite -quick-match buffer<cr>

let g:unite_enable_start_insert = 1

autocmd Filetype unite call s:UniteSettings()
function! s:UniteSettings()
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
endfunction

let g:unite_source_history_yank_enable = 1
nnoremap <space>y :Unite history/yank<cr>

" ag
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nocolor --nogroup'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_grep_max_candidates = 200

vnoremap /g y:Unite grep::-iHRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>

