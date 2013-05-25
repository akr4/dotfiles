set laststatus=2

" change color along with mode
hi statusline ctermfg=4 ctermbg=0
au InsertEnter * hi statusline ctermfg=9 ctermbg=0
au InsertLeave * hi statusline ctermfg=4 ctermbg=0

" http://blog.ruedap.com/entry/20110712/vim_statusline_git_branch_name
set statusline=%<     " 行が長すぎるときに切り詰める位置
set statusline+=[%n]  " バッファ番号
set statusline+=%m    " %m 修正フラグ
set statusline+=%r    " %r 読み込み専用フラグ
set statusline+=%h    " %h ヘルプバッファフラグ
set statusline+=%w    " %w プレビューウィンドウフラグ
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}  " fencとffを表示
set statusline+=%y    " バッファ内のファイルのタイプ
set statusline+=\     " 空白スペース
set statusline+=%t    " ファイル名のみ
set statusline+=%=    " 左寄せ項目と右寄せ項目の区切り
set statusline+=%{fugitive#statusline()}  " Gitのブランチ名を表示
set statusline+=\ \   " 空白スペース2個
set statusline+=(%c,%1l)
set statusline+=\ \   " 空白スペース2個
set statusline+=%p%%  " ファイル内の何％の位置にあるか

set statusline=%<%m%r%h%w\ %t\ (%{&fenc}:%{&ff})\ %y%=%{fugitive#statusline()}\ \ (%4c,%4l)\ \%3p%%

