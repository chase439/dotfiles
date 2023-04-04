# Use symlink.ps1 to link this file to PowerShell profile location

# ------------------------------
# Git
# ------------------------------
function gs { git status }
function gb { git branch }
function gc { git checkout }
function gp { git remote prune origin }
function gmnff { git merge --no-ff }
function gd { git diff }
function gdc { git diff --cached }
function gl { git log -n 4 }
function gg {
  # auto exclude files in .git and .gitignore
  #git grep $@ -- './*' ':(exclude).vim/' ':(exclude)runcom/.gitk' ':(exclude).vscode/extensions' ;
}