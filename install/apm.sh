if ! is-macos -o ! is-executable apm; then
  echo "Skipped: Atom Package Manager Installer"
  return
fi

packages=(
  atom-html-preview
  atom-beautify  # format file's indentation
  # teletype # Share your workspace with team members & collaborate on code in real time
  # linter # base linter, tool that analyzes source code to flag programming errors
  # linter-jshint # js linter
  # pigments # display colors in project and files.
  # atom-live-server # launch a http server with live reload capability.
  # ask-stack # search stackoverflow, Ctrl+Alt+A, questions and answers
  # emmet # write html code faster
)

apm install "${packages[@]}"
