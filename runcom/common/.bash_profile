# ------------------------------
# Unlimited bash history
# ------------------------------
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F] [%T] " # display datetime in history
# use a different filename b/c .bash_history get truncated by certain sessions.
export HISTFILE=~/.bash_unlimited_history

# ------------------------------
# Linux
# ------------------------------
alias h='history'
# alias ls='ls --color=auto' # bad on Darwin
alias l.="ls -d .*" # list hidden files
alias ll='ls -al'
alias ltr='ls -ltr'
tu() { top -u $USER ; }
alias ip='ifconfig' # /sbin/ifconfig
net_open() { netstat -tulpn ; } # list open ports
meminfo() { free -m -l -t ; } # RAM mem info
psmem() { ps auxf | sort -nr -k 4 ; } # list top processes eating most CPU
psmem10() { psmem | head -10 ; } # list top 10 processes eating most CPU
cpuinfo() { less /proc/cpuinfo ; }
etime_user() { ps -u $USER -o pid,cmd,etime ; } # display elapsed time for all user's processes
etime_pid() { ps -o pid,cmd,etime -p ; } # prompt for pid, display elapsed time
countf() { find ${1:-.} -type f | wc -c ; } # recursively count #files in a directory
countd() { find ${1:-.} -type f -not -path '.' | wc -c ; } # recursively count #dirs in a directory, exclude .
countl() { find ${1:-.} -type l | wc -c ; } # recursively count #sym_links in a directory
count_lines_of_code_in_dir() { find ${1:-.} -type f -print0 | xargs -0 wc -l ; }  # recursively
sizes_of_files() { du -S | sort -n -r | more $@ ; } # recursively, order by largest first
sizes_of_dirs() { du -skh $@ ; }
sizes_of_drives() { df -H ; }
echo_path() { echo $PATH | tr ':' '\n' ; } # list PATHs, separate : into newline
root() { sudo su - root ; }
d2u() { find ${1:-.} -type f -print0 | xargs -0 dos2unix ; }  # dos2unix all files recursively in the specified directory
empty-files-in-current-dir() {
  read -p 'Are you sure? (N or Ctrl+C to cancel!) ' u_sure;
  if [[ "$u_sure" != "N" ]]; then
    find . -type f -exec sh -c '>"{}"' \; ;
  fi
}
# if argument is an alias, function or binary, return true, else false
is-executable() {
  type "$1" >/dev/null 2>&1
  return $?
}

extract() {
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2)  tar xjf "$1"      ;;
      *.tar.gz)   tar xzf "$1"      ;;
      *.tar.Z)    tar xzf "$1"      ;;
      *.bz2)      bunzip2 "$1"      ;;
      *.rar)      unrar x "$1"      ;;
      *.gz)       gunzip "$1"       ;;
      *.jar)      unzip "$1"        ;;
      *.tar)      tar xf "$1"       ;;
      *.tbz2)     tar xjf "$1"      ;;
      *.tgz)      tar xzf "$1"      ;;
      *.zip)      unzip "$1"        ;;
      *.Z)        uncompress "$1"   ;;
      *.7z)       7z x "$1"         ;;
      *)          echo "do not know how to extract '$1'" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
# To compress files:
  # zip file.zip file1 file2
  # zip -r myfiles.zip mydir
  # zip -r myfiles.zip mydir -x *.git*  # exclude .git
# To decompress:
  # unzip file.zip -d output_dir
# To list:
  # jar tvf $@;  # list files inside .jar file
  # tar -ztvf $@;  # list files inside .tar.gz file

pathmunge () {
  # if path is in PATH, then do nothing, else add it to PATH
  case ":${PATH}:" in
    *:"$1":*)
      ;;
    *)
      if [ "$2" = "after" ] ; then
        PATH=$PATH:$1
      else
        PATH=$1:$PATH
      fi
  esac
}

# print the command before executing it
function exec_cmd() {
  if [ $# -eq 1 ] ; then
    echo $1
    eval $1
  fi
}

weather(){ curl -s "http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml?query=${@:-22033}"|perl -ne '/<title>([^<]+)/&&printf "\x1B[0;34m%s\x1B[0m: ",$1;/<fcttext>([^<]+)/&&print $1,"\n"';}

## remove swapfiles
# rm_swapfiles() { find app/ db/ -type f -name .\*.sw? | xargs rm ; }
## nuke given string from all files in a directory
# grep -rl "controller_x" spec/ | xargs sed -i "/controller_x/d"

## IP / host / lookup
# host <domain_name>  # find IP
# dig -x <IP>  # find domain name, reverse lookup
# nslookup <IP/DN> # DNS lookup, find IP of load balancer

# ------------------------------
# Easy cd navigation
# ------------------------------
DIRS_PATH=$DOTFILES_PATH/runcom/.dirs
# if file doesn't exist, create it
if [ ! -f $DIRS_PATH ]; then
  touch $DIRS_PATH
fi
source $DIRS_PATH
show-dirs() { cat $DIRS_PATH ; }
empty-dirs() { > $DIRS_PATH ; }
delete-dir() {
  # delete any dir aliases matching name argument, mac requires backup
  sed -i.bak "/cd$1=/d" $DIRS_PATH ;
}
save-dir() {
  if [ -z "$1" ] ; then
    echo "No argument supplied. Usage save-dir <name-alias>"
  elif [[ "$1" =~ [^a-zA-Z0-9] ]]; then
    echo "Name can only contain alphanumeric chars"
  else
    delete-dir $1 ;
    echo "alias cd$1='cd `pwd`'" >> $DIRS_PATH ; # append dir
    source $DIRS_PATH ;
  fi
}

# ------------------------------
# PS1 Prompt Format
# ------------------------------
## Colors
# RESET="\[\017\]"
# NORMAL="\[\033[0m\]"
# GREEN="\[\033[32m\]"
# YELLOW="\[\033[33m\]"
# PS1="${GREEN}\u@\h${NORMAL}:${YELLOW}\w\$(__git_ps2)${NORMAL}\n$ "

# ------------------------------
# Tools Specific Config
# ------------------------------
export GREP_OPTIONS='--color=auto' # color matched pattern(s)
# export GREP_COLOR='green'
PAGER=/usr/bin/less
GIT_PAGER='less -r' # wrap long lines when doing git diff
CUCUMBER_FORMAT='pretty'
LESS='-isr'
EDITOR=vim # used by "bundle open <gem_name>" and "git commit"

# follow symbolic links, include hidden files, exclude .git
# used for fzf command, requires fd executable
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# ------------------------------
# Database
# ------------------------------
mysql_login() { mysql -u root -p$MYSQL_ROOT_PASS $@ ; }
mysql_stop() { mysqladmin shutdown -u root -p$MYSQL_ROOT_PASS ; }
mysql_dump_dbs() {  # dump all databases
  exec_cmd "mysqldump -uroot -p$MYSQL_ROOT_PASS --all-databases > DB_backup.sql"
}
# mysql -u root -p$MYSQL_ROOT_PASS dev1_db < $1  # restore a DB
# mysql_upgrade -u root -p$MYSQL_ROOT_PASS ; # upgrade databases

# ------------------------------
# VIM
# ------------------------------
# replace all tabs with spaces in .erb files
vim_tab_replace_erb_files() { find . -type f -name "*.erb" | xargs gvim ; } # then ":argo retab | update" in vim
rm_vim_swapfiles() { find ~/.vim-temp -type f -print0 | xargs -0 rm ; }
gv_last_session() { gv -S ~/vs/temp ; }

if [[ "$OSTYPE" == "darwin"* ]]; then # Mac OS
  alias gv='mvim'
elif [[ ! -s $DISPLAY ]] ; then  # X11 is running
  alias gv='gvim'
else
  alias gv='gvim'
fi
complete gv && complete -r gv  # fix gv autocompletion

# ------------------------------
# SSL
# ------------------------------
cert_expiration() { openssl x509 -noout -dates -in $1 ; }
cert_verify_against_ca() { openssl verify -CAfile $1 $2 ; }  # cafile, cert_and_key_file
cert_test_against_server() { openssl s_client -connect localhost:8001 -CAfile $1 $2 ; }  # cafile, cert_and_key_file

# ------------------------------
# Git
# ------------------------------
alias gs='git status'
alias ggs='git status'
alias gb='git branch'
alias gc='git checkout'
alias gp='git remote prune origin'
alias gmnff='git merge --no-ff'
alias gd='git diff'
alias gl='git log -n 4'
gg() {
  # auto exclude files in .git and .gitignore
  git grep $@ -- './*' ':(exclude).vim/' ':(exclude)runcom/.gitk' ':(exclude).vscode/extensions' ;
}
ggd() {
  pushd $DOTFILES_PATH > /dev/null
  gg $@ ;
  popd > /dev/null
}
git_chmodx() { git update-index --chmod=+x $1 ; }
git_chmodls() { git ls-tree HEAD $1 ; }
glola() { git log --graph --decorate --pretty=oneline --abbrev-commit --all ; }
g5commits() { git for-each-ref --count=5 --sort=-committerdate refs ; }  # list 5 most recent commits across all branches
# git remote set-url origin <newurl> # change url of git remote

# ------------------------------
# Rails Related
# ------------------------------
be() { bundle exec $@ ; }
rcd() { be rails console -e development ; }
#irb() { ruby -S irb ; } # w/out readline installed; allows backspace & arrow keys to be used
# be rspec spec
# alias rspec='rspec --color --format documentation'
# be rake cucumber:wip
cuke() { be rake cucumber ; }
jaz() { be rake jasmine ; }
tcov() {  be rake spec:rcov ; }
migrated() { be rake db:migrate ; }
migratedt() { be rake db:migrate db:test:prepare ; }

