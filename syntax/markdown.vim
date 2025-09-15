"===================================================================================================
"
"   Version : 1.0.0
"   Title   : Markdown Syntax
"
"   Description
"       customized syntax for Markdown
"
"   Additional info
"
"   Author  : TBD9rain
"
"===================================================================================================

" KaTeX
syn region  markdownKatex
    \ start='\$'
    \ end='\$'

syn region  markdownKatex
    \ start='\$\$'
    \ end='\$\$'

hi  def link    markdownKatex   String

