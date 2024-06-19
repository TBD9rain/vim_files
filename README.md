**This repository contains files for Vim to use.**


# User Dictionary

Files in `.\spell` are dictionary added by user for Vim spell checking.


# Template

The `./template/config.vim` is the vim script for template automatically loading.

|Template File          |Description                                |
|:---                   |:---                                       |
|`template.gitignore`   |.gitignore                                 |
|`source.v`             |empty verilog source code                  |
|`testbench.v`          |empty verilog testbench                    |
|`modelsim.do`          |ModelSim & QuestaSim simulation script     |
|`source.c`             |empty C language code                      |


# Icon Configuration for Vim-DevIcons

The Icon Configuration file is `.\dev_icons\icon_config.vim`.


# Language Server

The implementation of language servers are ignored by git.
Only the relevant configuration files are tracked.


## Verible

Verible is a language server for for verilog and systemverilog coding.
Download the Verible from [Verible Release](https://github.com/chipsalliance/verible/releases).

`.\languageserver\verible\verible-verilog-lint.config` is a Verible linter configuration file.


