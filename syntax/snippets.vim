"===================================================================================================
"
"   Title   : snippets
"   Version : 1.0.0
"
"   Description
"       customized syntax for snippet files in UltiSnips
"
"   Additional info
"
"   Author  : TBD9rain
"
"===================================================================================================

" tab stop with predefined selection

" reload snipTabStop syntax region
syn region snipTabStop
    \ matchgroup=snipTabStop
    \ start="\${\d\+[:|}]\@=" end="}" extend
    \ contained contains=snipTabStopDefault,snipTabStopSelection
syn region snipTabStopSelection
    \ matchgroup=snipTabStop
    \ start="|" end="|" keepend
    \ contained contains=snipTabStopSelectionItem,snipTabStopSelectionSeparator,snipTabStopEscape,snipBalancedBraces,@snipTabStopTokens

syn match snipTabStopSelectionItem "[^,]*" contained
syn match snipTabStopSelectionSeparator "," contained

hi def link snipTabStopSelectionItem        String
hi def link snipTabStopSelectionSeparator   Define

