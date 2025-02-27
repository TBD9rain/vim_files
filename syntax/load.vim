"==================
"   TBD9rain SYNTAX
"==================


"------------
"   File Type
"------------

" verilog files
autocmd BufNewFile,BufRead *.v set filetype=verilog
" systemverilog files
autocmd BufNewFile,BufRead *.sv set filetype=systemverilog
" c files
autocmd BufNewFile,BufRead *.c set filetype=c
" modelsim do files
autocmd BufNewFile,BufRead *.do set filetype=tcl
" git ignore files
autocmd BufNewFile,BufRead .gitignore set filetype=gitignore


"-----------------
"   Syntax Setting
"-----------------

let g:my_syntax_path = expand('<sfile>:p:h')

" binary files
autocmd BufReadPre *.bin set binary

" set json comment prefix
autocmd FileType json syntax match Comment "\/\/.\+$"

" gitcommit
" work with vim default syntax script
let g:gitcommit_summary_length=-1

" python
autocmd FileType python execute "source " . my_syntax_path . "/python.vim"

" markdown
autocmd FileType markdown execute "source " . my_syntax_path . "/markdown.vim"

