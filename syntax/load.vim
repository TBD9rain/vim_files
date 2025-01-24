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

" binary files
autocmd BufReadPre *.bin set binary

" set json comment prefix
autocmd FileType json syntax match Comment "\/\/.\+$"

