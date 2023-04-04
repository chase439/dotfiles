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
function gg($String) {
  # auto exclude files in .git and .gitignore, search for both tracked and untracked files
  git grep --ignore-case --untracked $String './*' ':(exclude).vim/' ':(exclude)runcom/.gitk' ':(exclude).vscode/extensions' ;
}
# If currently in a git repo, then use git grep since it's faster, otherwise use powershell commands
function gg2($String) {
    if (git rev-parse --is-inside-work-tree 2> $null) {
        git grep --ignore-case --name-only --untracked $String | % { Join-Path $pwd.Path ($_ -Replace '\/','\') | Get-Item; };
    } else {
        gci -Recurse -File -Path * -Exclude @('*.pdf','*.exe','*.dll','','','') | ? { $_ | sls $string -Quiet; };
    };
};

# gci cmdlet is alias for Get-ChildItem
# wildcard is prefixed and suffixed.
function ffiles($String) {
	Get-ChildItem -File -Recurse -Filter "*$String*" ;
};
function fpaths($String) {
	Get-ChildItem -Path "." -Recurse -Filter "*$String*" ;
};