if ! is-macos -o ! is-executable brew; then
  echo "Skipped: Homebrew-Cask"
  return
fi

brew tap caskroom/versions
brew tap caskroom/cask
brew tap caskroom/fonts

# Install packages

apps=(
  # alfred
  # dash2
  # dropbox
  firefox
  # flux
  # font-fira-code
  # glimmerblocker
  google-backup-and-sync # Google Drive
  google-chrome
  # google-chrome-canary
  # hammerspoon
  # kaleidoscope
  kindle
  # macdown
  macvim
  # opera
  # screenflow # record Mac screen to create screencast videos
  # slack
  # sourcetree # Git tree GUI, similar to gitk
  # spotify
  # sublime-text
  # transmit
  tuxera-ntfs # read and write Windows NTFS
  virtualbox
  # visual-studio-code
  # vlc
)

brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
# brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize webpquicklook suspicious-package qlvideo

# Link Hammerspoon config
# if [ ! -d ~/.hammerspoon ]; then ln -sfv "$DOTFILES_DIR/etc/hammerspoon/" ~/.hammerspoon; fi
