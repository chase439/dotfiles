
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

is-executable() {
  local BIN=`command -v "$1" 2>/dev/null`
  [[ ! $BIN == "" && -x $BIN ]] && true || false
}
