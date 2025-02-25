#===================================================================================================
# 
#   File            :   vim_spellfile_sort.py
#   Version         :   v1.0.0
#   Title           :   vim_spellfile_sort
# 
#   Description     :   Sort words in Vim spell file and generate binary spell file
# 
#   Additional info :
#   Version history :
#                       v1.0.0
# 
#   Author          :   lshi1
#   Email           :
# 
#===================================================================================================

import argparse
import logging
import sys
import os
import subprocess

# Argument Resolving
parser =\
    argparse.ArgumentParser(description='Sort words in Vim spell file and generate binary spell file.')

parser.add_argument('--path', type=str,
                    default=r'~/vim_config/vim_files/spell/en.utf-8.add', help='Define the path of Vim spell file.')
parser.add_argument('-v','--verbose',
                    action='store_true', help='Enable verbose information output.')

# Set Output Level
args = parser.parse_args()
logging.basicConfig(level=(logging.DEBUG if args.verbose else logging.INFO),
                    format="%(levelname)s: %(message)s")

# Test Vim Spell File Path
current_path = os.getcwd()
logging.debug(current_path)

spellfile_path = os.path.relpath(os.path.expanduser(args.path), current_path)
logging.debug(spellfile_path)

if os.path.exists(spellfile_path):
    logging.debug('Vim spell file found.')
else:
    logging.error('Vim spell path not found!')
    logging.error('Check the ABSOLUTE path to the vim spell file.')
    sys.exit(1)

# Obtain Git Staging Area File Names
try:
    cmd_output = subprocess.run(['git', 'diff', '--staged', '--name-only'],
                            capture_output=True, text=True, check=True)
except:
    logging.error('Git diff command error.')
    sys.exit(1)

logging.debug('"git diff --staged --name-only" output:')
logging.debug('\n'+cmd_output.stdout)

git_staged_files = cmd_output.stdout.split('\n')
git_staged_files = [os.path.normpath(path) for path in git_staged_files]

if spellfile_path in git_staged_files:
    logging.debug('Detected vim spell file variation.')

    with open(spellfile_path, 'r', encoding='utf-8') as spell_file:
        lines = spell_file.readlines()

    sorted_lines = sorted(lines, key=str.lower)
    logging.debug(sorted_lines)

    with open(spellfile_path, 'w', encoding='utf-8') as spell_file:
        spell_file.writelines(sorted_lines)

