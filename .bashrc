# Get current dir knowing this file is a symlink from $HOME
export DOTFILES_PATH="$( cd "$( dirname "$( readlink "${BASH_SOURCE[0]}" )" )" && pwd )"

# Add dotfiles bin to PATH
export PATH="$PATH:$DOTFILES_PATH/bin"

# ------------------------------
# File list to source
# ------------------------------
files=()
files+=("$HOME/.bashrc_developer") # PORT numbers
files+=("$HOME/.bashrc_secrets") # credentials, keys
files+=("common/.bashrc")

## C2S vs Private Network
# files+=("common/.bashrc_c2s")

## Project specific
files+=("projects_specific/.bashrc_ac")

## RVM, load into shell as a function
files+=("${rvm_path:-$HOME/.rvm}/scripts/rvm")

## Iterate through files; if file exists, then source it
for file in "${files[@]}"
do
  [[ -s $file ]] && . $file
done

print_files() { printf '%s\n' "${files[@]}" ; }
cddotfiles() { cd $DOTFILES_PATH ; }
