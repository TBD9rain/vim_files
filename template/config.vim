" TEMPLATE PATH
let g:my_template_path = expand('<sfile>:p:h')


" LOAD TEMPLATE

" verilog code template
autocmd BufNewFile *{_tb}\@<!.v execute '0r ' . g:my_template_path . '/source.v'
" verilog testbench template
autocmd BufNewFile *_tb.v execute '0r ' . g:my_template_path . '/testbench.v'
" modelsim do file template
autocmd BufNewFile *.do execute '0r ' . g:my_template_path . '/modelsim.do'
" c code template
autocmd BufNewFile *.c execute '0r ' . g:my_template_path . '/source.c'
" git ignore template
autocmd BufNewFile .gitignore execute '0r ' . g:my_template_path . '/template.gitignore'
" snippet template
autocmd BufNewFile *.snippets execute '0r ' . g:my_template_path . '/template.snippets'


