"=====================
"   TBD9rain TEMPLATES
"=====================


"----------------
"   Load Template
"----------------

let g:my_template_path = expand('<sfile>:p:h')

" verilog rtl code template
" autocmd BufNewFile *{_tb}\@<!.v execute '0r ' . g:my_template_path . '/source.v'
" verilog testbench template
" autocmd BufNewFile *_tb.v execute '0r ' . g:my_template_path . '/testbench.v'
" modelsim do file template
autocmd BufNewFile *.do execute '0r ' . g:my_template_path . '/questasim.do'
" c code template
" autocmd BufNewFile *.c execute '0r ' . g:my_template_path . '/source.c'
" python code template
" autocmd BufNewFile *.py execute '0r ' . g:my_template_path . '/source.py'
" git ignore template
autocmd BufNewFile .gitignore execute '0r ' . g:my_template_path . '/template.gitignore'
" snippet template
" autocmd BufNewFile *.snippets execute '0r ' . g:my_template_path . '/template.snippets'
" systemverilog code template
" autocmd BufNewFile *.sv execute '0r ' . g:my_template_path . '/general.sv'

