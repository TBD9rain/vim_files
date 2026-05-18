#===================================================================================================
#
#   Title   : sort_vim_spell_dict
#   Version : 1.0.0
#
#   Description
#
#   Additional info
#
#   Author  : TBD9rain
#
#===================================================================================================

import argparse
import logging
import sys
import os
import subprocess
import shutil

# Argument Resolving
parser =\
    argparse.ArgumentParser(description='Sort words in Vim spell dictionary and generate binary file.')

parser.add_argument('--path', type=str,
                    default='spell',
                    help='define Vim spell directory path (absolute path or path relative to git root).')
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

try:
    git_root = subprocess.run(
        ['git', 'rev-parse', '--show-toplevel'],
        capture_output=True, text=True, check=True
    ).stdout.strip()
except Exception:
    logging.error('Failed to get git root path.')
    sys.exit(0)

logging.debug(f'Git root path:\n\t{git_root}')

spell_dir = os.path.expanduser(args.path)
if os.path.isabs(spell_dir):
    spell_dir = os.path.abspath(spell_dir)
else:
    spell_dir = os.path.abspath(os.path.join(git_root, spell_dir))

spelldict_path = os.path.join(spell_dir, spelldict_name)
spelldict_git_path = os.path.normpath(os.path.relpath(spelldict_path, git_root))

logging.debug(f'Spell dictionary absolute path:\n\t{spelldict_path}')
logging.debug(f'Spell dictionary git path:\n\t{spelldict_git_path}')

if os.path.exists(spelldict_path):
    logging.info('Spell dictionary found.')
else:
    logging.error('Spell dictionary not found!')
    logging.error('Check the path to the vim spell directory.')
    sys.exit(0)

# Search Dictionary File in Staging Area
try:
    cmd_output = subprocess.run(['git', '-C', git_root, 'diff', '--staged', '--name-only'],
                            capture_output=True, text=True, check=True)
except:
    logging.error('Git diff command error.')
    sys.exit(0)

logging.debug('"git diff --staged --name-only" output:' + '\n\n'+cmd_output.stdout)

git_staged_files = cmd_output.stdout.split('\n')
git_staged_files = [os.path.normpath(path.strip()) for path in git_staged_files if path.strip()]

if spelldict_git_path not in git_staged_files:
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
stage_targets = [spelldict_git_path]
vim_executable = None
for candidate in ('vim', 'nvim', 'gvim'):
    vim_executable = shutil.which(candidate)
    if vim_executable:
        break

if vim_executable:
    try:
        # Use git-relative forward-slash path to avoid backslash escaping issues in Vim command.
        vim_spell_path = spelldict_git_path.replace(os.sep, '/')
        vim_mkspell_cmd = f':execute "mkspell! " . fnameescape("{vim_spell_path}")'
        subprocess.run(
            [vim_executable, '-es', '-c', vim_mkspell_cmd, '-c', 'quit'],
            check=True,
            cwd=git_root,
            capture_output=True,
            text=True
        )
        stage_targets.append(spelldict_git_path + '.spl')
        logging.info('Generated spell file.')
    except subprocess.CalledProcessError as e:
        logging.error('Failed to generate spell file.')
        logging.debug(f'vim stdout:\n{e.stdout}')
        logging.debug(f'vim stderr:\n{e.stderr}')
        logging.warning('Continue without updating spell binary file.')
else:
    logging.warning('No vim executable found, skip spell binary generation.')

# Add Dictionary and Spell File into Staging Area
try:
    subprocess.run(['git', '-C', git_root, 'add', *stage_targets], check=True)
    logging.info('Added updated files into staging area.')
except:
    logging.error('Failed to add Vim dictionary or spell file.')

