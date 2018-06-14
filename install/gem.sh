if ! is-macos -o ! is-executable brew; then
  echo "Skipped: gem"
  return
fi

brew install gpg2

\curl -sSL https://get.rvm.io | bash -s stable

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

rvm install 1.9.3
rvm install 2.5
rvm use 1.9.3 --default

gem install lunchy
gem install bundler
gem install foreman
# gem install pygmentize
