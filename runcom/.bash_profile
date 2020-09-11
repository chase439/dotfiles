# If not running interactively, exit
[ -z "$PS1" ] && return

# ------------------------------
# Env Variables
# ------------------------------
# Get current dir knowing ~/.bash_profile is a symlink
export DOTFILES_PATH="$( cd "$( dirname "$( readlink "${BASH_SOURCE[0]}" )" )/.." && pwd )"
export DOTFILES_DIR=$DOTFILES_PATH
export PATH="$PATH:$DOTFILES_PATH/bin" # Add to PATH
export PATH="/usr/local/sbin:$PATH:/usr/local/Cellar/node/10.1.0/bin" # Add to brew and node
export PATH="$PATH:/Users/chasetran7/workspace/software/elastic/elasticsearch-6.6.1/bin:/Users/chasetran7/workspace/software/elastic/kibana-6.6.1-darwin-x86_64/bin" # Add to Elasticsearch and Kibana to PATH

# ------------------------------
# (Full path) File list to source
# ------------------------------
files=()
files+=("$HOME/.bash_secrets") # credentials, keys
files+=("$DOTFILES_PATH/runcom/common/.bash_profile") # this sources .dirs
files+=("$DOTFILES_PATH/system/.function")
files+=("$DOTFILES_PATH/system/.prompt")

# AWS vs Other Networks
# files+=("$DOTFILES_PATH/runcom/common/.bash_aws")

# Project specific
files+=("$DOTFILES_PATH/runcom/projects_specific/.bash_ac")
files+=("$DOTFILES_PATH/runcom/projects_specific/.bash_bluestar")

# RVM, load into shell as a function
files+=("${rvm_path:-$HOME/.rvm}/scripts/rvm")
export NVM_DIR="$HOME/.nvm"
files+=("/usr/local/opt/nvm/nvm.sh") # This loads nvm
files+=("/usr/local/opt/nvm/etc/bash_completion.d/nvm") # This loads nvm bash_completion

files+=("$HOME/.bash_developer") # PORT numbers
files+=("$HOME/.fzf.bash") # fzf

# Iterate through files; if file exists, then source it
for file in "${files[@]}"
do
  [[ -s "$file" ]] && source "$file"
done

# ------------------------------
# Functions
# ------------------------------
print_files() { printf '%s\n' "${files[@]}" ; }

# cdblops # default to folder
cdcapgap # default to folder
