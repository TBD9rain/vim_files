" f-string 
syn region   pythonFString
    \ matchgroup=pythonQuotes
    \ start=+[uU]\=[fF]\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
    \ contains=pythonEscape,@spell
syn region  pythonFString
    \ matchgroup=pythonTripleQuotes
    \ start=+[uU]\=[fF]\z('''\|"""\)+ end="\z1" skip="\\\\\|\\\z1" keepend
    \ contains=pythonEscape,pythonSpaceError,pythonDoctest,@Spell

syn region  pythonFStringArgs
    \ matchgroup=pythonFStringArgsBracket
    \ start="{" end="}"
    \ contained containedin=pythonFString

syn match   pythonFStringArgsColon
    \ ":"
    \ contained containedin=pythonFStringArgs

hi  def link    pythonFString               String
hi  def link    pythonFStringArgs           NONE
hi  def link    pythonFStringArgsBracket    Statement
hi  def link    pythonFStringArgsColon      Statement

