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
alias ls='ls --color=auto'
alias l.="ls -d .*" # list hidden files
alias ll='ls -al'
alias ltr='ls -ltr'
tu() { top -u $USER ; }
alias ip='ifconfig'
net_open { netstat -tulpn ; } # list open ports
meminfo() { free -m -l -t ; } # RAM mem info
psmem() { ps auxf | sort -nr -k 4 ; } # list top processes eating most CPU
psmem10() { psmem | head -10 ; } # list top 10 processes eating most CPU
cpuinfo() { less /proc/cpuinfo ; }
root() { sudo su - root ; }

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

weather(){ curl -s "http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml?query=${@:-22033}"|perl -ne '/<title>([^<]+)/&&printf "\x1B[0;34m%s\x1B[0m: ",$1;/<fcttext>([^<]+)/&&print $1,"\n"';}

# ------------------------------
# Tools Specific Config
# ------------------------------
PAGER=/usr/bin/less
GIT_PAGER='less -r' # wrap long lines when doing git diff
CUCUMBER_FORMAT='pretty'
LESS='-isr'
EDITOR=vim # used by "bundle open <gem_name>" and "git commit"

# print the command before executing it
function exec_cmd() {
  if [ $# -eq 1 ] ; then
    echo $1
    eval $1
  fi
}

# ------------------------------
# SSL
# ------------------------------
cert_expiration() { openssl x509 -noout -dates -in $1 ; }
cert_verify_against_ca() { openssl verify -CAfile $1 $2 ; }  # cafile, cert_and_key_file

ostype=$(uname)
# if on Windows or X11 is running
if [ $ostype != "Linux" ] || [ ! -s $DISPLAY ] ; then
  alias gv='mvim'
fi
alias gvim='mvim'

# ------------------------------
# Git
# ------------------------------
alias gs='git status'
alias gb='git branch'
alias gc='git checkout'
alias gp='git remote prune origin'
alias gmnff='git merge --no-ff'
alias gd='git diff'
alias gl='git log -n 4'
gg() { (dotfilesdir && git grep $@); }
git_chmodx() { git update-index --chmod=+x $1 ; }
git_chmodls() { git ls-tree HEAD $1 ; }
glola() { git log --graph --decorate --pretty=oneline --abbrev-commit --all ; }
gb5() { git for-each-ref --count=5 --sort=-committerdate refs ; }  # list 5 most recent commits across all branches
# git remote set-url origin <newurl> # change url of git remote

# ------------------------------
# Rails Related
# ------------------------------
be() { bundle exec $@ ; }
rcd() { be rails console development ; }
#irb() { ruby -S irb ; } # w/out readline installed; allows backspace & arrow keys to be used
# be rspec spec
# alias rspec='rspec --color --format documentation'
# be rake cucumber:wip
migratedt() { be rake db:migrate db:test:prepare ; }

# ------------------------------
# Heroku
# ------------------------------
herokus() { heroku $@ --app cedar-appointmentcare-staging ; } 
herokup() { heroku $@ --app cedar-appointmentcare-prod ; } 
herokui() { heroku $@ --app cedar-appointmentcare-integ ; } 
alias herokup_logs='herokup logs --tail'
alias herokus_logs='herokus logs --tail'
alias herokui_logs='herokui logs --tail'
alias herokup_rconsole='herokup run rails console'
alias herokus_rconsole='herokus run rails console'
alias herokui_rconsole='herokus run rails console'
alias herokup_bash='herokup run bash'
alias herokus_bash='herokus run bash'
alias herokui_bash='herokui run bash'

# heroku pgbackups #display backups
# heroku pgbackups:capture --expire  #create newest DB, delete oldest BU
# heroku pgbackups:url [b350] #create URL for D/L
# curl -o stag_20130213.dmp <URL with quotes> #download heroku pgbackup dump from url
alias import_dump='pg_restore --verbose --clean --no-acl --no-owner -h localhost -U user1 -d appointmentcare_development' #pass in dump file, heroku pgbackups 

