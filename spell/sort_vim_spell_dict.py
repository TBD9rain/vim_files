#===================================================================================================
#
#   File            :   vim_spell_dict_sort.py
#   Version         :   v1.0.0
#   Title           :   vim_spell_dict_sort
#
#   Description     :   Sort words in Vim spell dictionary and generate spell file
#
#   Additional info :
#   Version history :
#                       v1.1.0
#
#   Author          :   TBD9rain
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
    argparse.ArgumentParser(description='Sort words in Vim spell dictionary and generate binary file.')

parser.add_argument('--path', type=str,
                    default=r'~/vim_config/vim_files/spell', help='define the path of Vim spell directory.')
parser.add_argument('-v','--verbose',
                    action='store_true', help='enable verbose information output.')

# Set Output Level
args = parser.parse_args()
logging.basicConfig(level=(logging.DEBUG if args.verbose else logging.INFO),
                    format="%(levelname)s: %(message)s")

# General Info
spelldict_name = 'en.utf-8.add'

logging.debug(f'Python version:\n\t{sys.version}')
logging.debug(f'Target spell dictionary name:\n\t{spelldict_name}')

# Check Spell Dictionary Path
current_path = os.getcwd()
logging.debug(f'Current path:\n\t{current_path}')

spelldict_path = os.path.relpath(os.path.expanduser(args.path), current_path)
spelldict_path = os.path.join(spelldict_path, spelldict_name)
logging.debug(f'Spell dictionary path:\n\t{spelldict_path}')

if os.path.exists(spelldict_path):
    logging.info('Spell dictionary found.')
else:
    logging.error('Spell dictionary not found!')
    logging.error('Check the ABSOLUTE path to the vim spell directory.')
    sys.exit(0)

# Search Dictionary File in Staging Area
try:
    cmd_output = subprocess.run(['git', 'diff', '--staged', '--name-only'],
                            capture_output=True, text=True, check=True)
except:
    logging.error('Git diff command error.')
    sys.exit(0)

logging.debug('"git diff --staged --name-only" output:' + '\n\n'+cmd_output.stdout)

git_staged_files = cmd_output.stdout.split('\n')
git_staged_files = [os.path.normpath(path) for path in git_staged_files]

if not spelldict_path in git_staged_files:
    logging.info('No spell dictionary is staged.')
    sys.exit(0)

# Sort Spell Dictionary
with open(spelldict_path, 'r', encoding='utf-8') as spelldict_r:
    lines = spelldict_r.readlines()

unique_lines = list(set(lines))
sorted_lines = sorted(unique_lines, key=str.lower)

try:
    with open(spelldict_path, 'w', encoding='utf-8') as spelldict_w:
        spelldict_w.writelines(sorted_lines)
    logging.info('Wrote sorted items into spell dictionary.')
except:
    logging.error('Failed to write into spell dictionary.')
    sys.exit(0)

# Generate Spell File
try:
    # vim -e -s -c ":mkspell! $filename" -c "quit"
    subprocess.run(['vim', '-es', '-c', f':mkspell! {spelldict_path}', '-c', 'quit'], shell=True)
    logging.info('Generated spell file.')
except:
    logging.error('Failed to generate spell file.')
    sys.exit(0)

# Add Dictionary and Spell File into Staging Area
try:
    subprocess.run(['git', 'add', spelldict_path, spelldict_path+'.spl'])
    logging.info('Added Vim dictionary and spell file.')
except:
    logging.error('Failed to add Vim dictionary or spell file.')

