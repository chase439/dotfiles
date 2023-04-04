Set-Environment "EMAIL" "Chase Tran <chasetran@microsoft.com>"
Set-Environment "GIT_AUTHOR_NAME" "Chase Tran","User"
Set-Environment "GIT_COMMITTER_NAME" $env:GIT_AUTHOR_NAME
git config --global user.name $env:GIT_AUTHOR_NAME
Set-Environment "GIT_AUTHOR_EMAIL" "chasetran@microsoft.com"
Set-Environment "GIT_COMMITTER_EMAIL" $env:GIT_AUTHOR_EMAIL
git config --global user.email $env:GIT_AUTHOR_EMAIL