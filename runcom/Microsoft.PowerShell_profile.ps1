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

# change Prompt with git branch and colors
function Write-BranchName () {
    try {
        $branch = git rev-parse --abbrev-ref HEAD

        if ($branch -eq "HEAD") {
            # we're probably in detached HEAD state, so print the SHA
            $branch = git rev-parse --short HEAD
            Write-Host " ($branch)" -ForegroundColor "red"
        }
        else {
            # we're on an actual branch, so print it
            Write-Host " ($branch)" -ForegroundColor "blue"
        }
    } catch {
        # we'll end up here if we're in a newly initiated git repo
        Write-Host " (no branches yet)" -ForegroundColor "yellow"
    }
}

function prompt {
    $base = "PS "
    $path = "$($executionContext.SessionState.Path.CurrentLocation)"
    $userPrompt = "$('>' * ($nestedPromptLevel + 1)) "

    Write-Host "`n$base" -NoNewline

    if (Test-Path .git) {
        Write-Host $path -NoNewline -ForegroundColor "green"
        Write-BranchName
    }
    else {
        # we're not in a repo so don't bother displaying branch name/sha
        Write-Host $path -ForegroundColor "green"
    }

    return $userPrompt
}