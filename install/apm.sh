if ! is-macos -o ! is-executable apm; then
  echo "Skipped: Atom Package Manager Installer"
  return
fi

packages=(
  # teletype # Share your workspace with team members & collaborate on code in real time
  # linter # base linter, tool that analyzes source code to flag programming errors
  # linter-jshint # js linter
  # pigments # display colors in project and files.
  # ask-stack # search stackoverflow, Ctrl+Alt+A, questions and answers
  # emmet # write html code faster
)

apm install "${packages[@]}"
