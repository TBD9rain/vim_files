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

