"====================
"   TBD9rain SNIPPETS
"====================


"-----------------------
"   Collect Snippet Path
"-----------------------

let s:snippet_path = expand('<sfile>:p:h')
let s:snippet_dir_list = []
call add(s:snippet_dir_list, s:snippet_path.'/basic')
" call add(s:snippet_dir_list, s:snippet_path.'/class_verify')
call add(s:snippet_dir_list, s:snippet_path.'/uvm')


"--------------------------------
"   Set Snippet Path of UltiSnips
"--------------------------------

let g:UltiSnipsSnippetDirectories = s:snippet_dir_list


"----------------------------
"   File Head Info Automation
"----------------------------

function! s:InsertSnippet(name)
    let s:key = eval('"'.substitute(g:UltiSnipsJumpOrExpandTrigger, '<', '\\<', 'g').'"')

    call setline('.', a:name)
    call feedkeys('A', 'nt')
    call feedkeys(s:key, 'mt')
endfunction

autocmd BufNewFile *.v call s:InsertSnippet('fileHeader')
autocmd BufNewFile *.py call s:InsertSnippet('fileHeader')
autocmd BufNewFile *.c call s:InsertSnippet('fileHeader')
autocmd BufNewFile *.sv call s:InsertSnippet('fileHeader')
autocmd BufNewFile *.snippets call s:InsertSnippet('fileHeader')
autocmd BufNewFile *.vim call s:InsertSnippet('fileHeader')

