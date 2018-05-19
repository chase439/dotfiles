# ------------------------------
# Env Variables
# ------------------------------
# Get current dir knowing ~/.bash_profile is a symlink
export DOTFILES_PATH="$( cd "$( dirname "$( readlink "${BASH_SOURCE[0]}" )" )" && pwd )"
export DOTFILES_DIR=$DOTFILES_PATH

# Add dotfiles bin to PATH
export PATH="$PATH:$DOTFILES_PATH/bin"

# ------------------------------
# File list to source
#  - require full paths
# ------------------------------
files=()
files+=("$HOME/.bashrc_developer") # PORT numbers
files+=("$HOME/.bashrc_secrets") # credentials, keys
files+=("$DOTFILES_PATH/runcom/common/.bashrc")

# AWS vs Other Networks
# files+=("$DOTFILES_PATH/runcom/common/.bashrc_aws")

# Project specific
files+=("$DOTFILES_PATH/runcom/projects_specific/.bashrc_ac")

# RVM, load into shell as a function
files+=("${rvm_path:-$HOME/.rvm}/scripts/rvm")

# Iterate through files; if file exists, then source it
for file in "${files[@]}"
do
  [[ -s "$file" ]] && source "$file"
done

# ------------------------------
# Functions
# ------------------------------
print_files() { printf '%s\n' "${files[@]}" ; }
cddotfiles() { cd $DOTFILES_PATH ; }
