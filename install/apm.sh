if ! is-macos -o ! is-executable apm; then
  echo "Skipped: Atom Package Manager Installer"
  return
fi

packages=(
  # emmet
  atom-html-preview
  atom-beautify  # format files
)

apm install "${packages[@]}"
