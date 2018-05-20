# If not running interactively, exit
[ -z "$PS1" ] && return

# ------------------------------
# Env Variables
# ------------------------------
# Get current dir knowing ~/.bash_profile is a symlink
export DOTFILES_PATH="$( cd "$( dirname "$( readlink "${BASH_SOURCE[0]}" )" )/.." && pwd )"
export DOTFILES_DIR=$DOTFILES_PATH
export PATH="$PATH:$DOTFILES_PATH/bin" # Add to PATH

# ------------------------------
# (Full path) File list to source
# ------------------------------
files=()
files+=("$HOME/.bash_developer") # PORT numbers
files+=("$HOME/.bash_secrets") # credentials, keys
files+=("$DOTFILES_PATH/runcom/common/.bash_profile")

# AWS vs Other Networks
# files+=("$DOTFILES_PATH/runcom/common/.bash_aws")

# Project specific
files+=("$DOTFILES_PATH/runcom/projects_specific/.bash_ac")

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

: <<'COMMENT'
/etc/profile
  The systemwide initialization file, executed for login shells
~/.bash_profile
  This file loads whenever Mac OS Terminal or its tab is open.
  The personal initialization file, executed for login shells
  e.g., when you login from another host, or login at the text
  console of a local unix machine. Similar to ~/.profile.
  Classically, ~/.profile is used by Bourne Shell.
~/.bashrc
  The individual per-interactive-shell startup file.
  The ~/.bashrc script is read every time a shell is started.
  ~/.bashrc should be as lightweight (minimal) as possible
  to reduce the overhead when starting a non-login shell.
~/.bash_logout
  The individual login shell cleanup file,
  executed when a login shell exits.
COMMENT

