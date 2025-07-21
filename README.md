**This repository contains files for Vim to use.**

**Branch lattice is always rebased onto main branch.**


# User Dictionary

`.\spell` includes the dictionary added by user for Vim spell checking.

The `.\spell\vim_spellfile_sort.ps1` is an powershell script
for automatic dictionary sorting with the git hook 'pre-commit'.


# Template

The `./template/config.vim` is the vim script for template automatically loading.

|Template File          |Description                                |
|:---                   |:---                                       |
|`template.gitignore`   |.gitignore                                 |
|`source.v`             |Verilog source code                        |
|`testbench.v`          |Verilog testbench                          |
|`questasim.do`         |QuestaSim & ModelSim simulation script     |
|`source.c`             |empty C language code                      |
|`general.sv`           |general SystemVerilog code                 |
|`testbench.sv`         |SystemVerilog testbench                    |


# Icon Configuration for Vim-DevIcons

The Icon Configuration file is `.\dev_icons\icon_config.vim`.


# Language Server

The implementation of language servers are ignored by git.
Only the relevant configuration files are tracked.


## Verible

Verible is a language server for for verilog and systemverilog coding.
Download the Verible from [Verible Release](https://github.com/chipsalliance/verible/releases).

`.\languageserver\verible\verible-verilog-lint.config` is a Verible linter configuration file.
For instruction about lint rule configuration, refer to *Rule Configuration* in [Verible Lint README](https://github.com/chipsalliance/verible/blob/master/verible/verilog/tools/lint/README.md).


## clangd

clangd is a language server for C / C++ coding.
Download the clangd from [get clangd started](https://clangd.llvm.org/installation.html)


# UltiSnips

|Snippets File              |Description                        |
|:---                       |:---                               |
|`snippets.snippets`        |for UltiSnips snippets editing     |
|`gitignore.snippets`       |for gitignore editing              |
|`markdown.snippets`        |for Markdown editing               |
|`verilog.snippets`         |for Verilog editing                |
|`verilog_pmi.snippets`     |for Lattice Verilog PMI invoking   |
|`c.snippets`               |for C language editing             |
|`systemverilog.snippets`   |for SystemVerilog editing          |

