"===================================================================================================
"
"   Version : 1.0.0
"   Title   : Python Syntax
"
"   Description
"       customized python syntax
"
"   Additional info
"
"   Author  : TBD9rain
"
"===================================================================================================

" f-string 
syn region   pythonFString
    \ matchgroup=pythonQuotes
    \ start=+[uU]\=[fF]\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
    \ contains=pythonEscape,@Spell
syn region  pythonFString
    \ matchgroup=pythonTripleQuotes
    \ start=+[uU]\=[fF]\z('''\|"""\)+ end="\z1" skip="\\\\\|\\\z1" keepend
    \ contains=pythonEscape,pythonSpaceError,pythonDoctest,@Spell

syn region  pythonFStringArgs
    \ matchgroup=pythonFStringArgsBracket
    \ start="{" end="}"
    \ keepend
    \ contained containedin=pythonFString

syn match   pythonFStringArgsModifier
    \ ":.\{-}\ze}"
    \ contained containedin=pythonFStringArgs

syn match   pythonFStringSplitColon
    \ ":"
    \ contained containedin=pythonFStringArgsModifier

hi  def link    pythonFString               String
hi  def link    pythonFStringArgs           NONE
hi  def link    pythonFStringArgsBracket    Statement
hi  def link    pythonFStringArgsModifier   SpecialChar
hi  def link    pythonFStringSplitColon     Statement

