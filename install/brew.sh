if ! is-macos -o ! is-executable ruby -o ! is-executable curl -o ! is-executable git; then
  echo "Skipped: Homebrew (missing: ruby, curl and/or git)"
  return
fi

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew upgrade

# Install packages

apps=(
  # asciiquarium
  bash-completion2
  bats
  # battery
  coreutils
  diff-so-fancy # enhance git diff
  dockutil # command line tool for managing dock items
  dos2unix
  # fasd
  # ffmpeg
  fzf  # fuzzy finder / file searcher
  # gifsicle
  git
  git-extras # git summary, effort, ignore
  # gnu-sed --with-default-names
  gpg2 # for rvm install
  # grep --with-default-names
  # hub # command line tool that wraps git for extra features
  # httpie # command line HTTP client, PUT, POST
  imagemagick@6
  # jq # command-line JSON processor
  # lynx # www browser
  # mackup # backup and restore mac setup
  # nano
  # pandoc # convert files from one markup format into another, powerful
  # peco # filter logs, process stats, find files; similar to grep, type as you think and view the current results.
  postgres
  # psgrep # shortcut for ps aux | gre
  python
  shellcheck # executable to check syntax and other issues with a shell script
  # ssh-copy-id # ssh to other computers
  # tree # directory listing tool
  # unar # decompress archives
  wget
  # wifi-password # Get the password of the wifi you're on
)

brew install "${apps[@]}"

# if fzf is installed, install its useful key bindings and fuzzy completion
# this basically creates ~/.fzf.bash and .fzf.zsh
[ -x "$(command -v fzf)" ] && $(brew --prefix)/opt/fzf/install

# export DOTFILES_BREW_PREFIX_COREUTILS=`brew --prefix coreutils`
# set-config "DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_CACHE"

# ln -sfv "$DOTFILES_DIR/etc/mackup/.mackup.cfg" ~

# have launchd start postgresql now and restart at login:
brew services start postgresql
