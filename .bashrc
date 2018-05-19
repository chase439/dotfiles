# Get current dir knowing this file is a symlink from $HOME
export DOTFILES_PATH="$( cd "$( dirname "$( readlink "${BASH_SOURCE[0]}" )" )" && pwd )"

# Add dotfiles bin to PATH
export PATH="$PATH:$DOTFILES_PATH/bin"

# ------------------------------
# File list to source
#  - require full paths
# ------------------------------
files=()
files+=("$HOME/.bashrc_developer") # PORT numbers
files+=("$HOME/.bashrc_secrets") # credentials, keys
files+=("$DOTFILES_PATH/common/.bashrc")

# AWS vs Other Networks
# files+=("$DOTFILES_PATH/common/.bashrc_aws")

# Project specific
files+=("$DOTFILES_PATH/projects_specific/.bashrc_ac")

# RVM, load into shell as a function
files+=("${rvm_path:-$HOME/.rvm}/scripts/rvm")

# Iterate through files; if file exists, then source it
for file in "${files[@]}"
do
  [[ -s "$file" ]] && source "$file"
done

print_files() { printf '%s\n' "${files[@]}" ; }
cddotfiles() { cd $DOTFILES_PATH ; }
sbashrc() { cd $DOTFILES_PATH ; }
