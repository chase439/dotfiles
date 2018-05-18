
# change command prompt to include git branch
#export PS1="\W \[\033[32m\]\`ruby -e \"print (%x{git branch 2> /dev/null}.each_line.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`\[\033[37m\]$\[\033[00m\] "  # keep apostrophe as is

export EDITOR=mvim  # for bundle open <gem>

export PATH=/usr/local/bin:$PATH #recommended by "brew doctor", this means use Homebrew's programs before system-provided programs; can sudo vi /etc/paths instead to move it to top of list;
export PATH=/usr/local/git/bin:$PATH # git 1.7.11.3
## Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
export CUCUMBER_FORMAT='pretty'

# AppointmentCare Specific
#alias ac='cd /Users/chasetran7/dev/ac/appointmentcare-repo'
alias error_tail='tail -f /Users/chasetran7/dev/ac/appointmentcare-repo/log/development.log | grep -i error'
alias gems='cd /Users/chasetran7/.rvm/gems/ree-1.8.7-2012.02@appointmentcare/gems'
alias rspec='rspec --color --format documentation'
alias spex='bundle exec rake spec'
alias cuke='bundle exec rake cucumber'
alias bspec='bundle exec rspec'
alias bcucu='bundle exec cucumber'
alias start_consolep='herokup run rails console'
alias start_consoles='herokus run rails console'
alias start_consoled='rails console'
alias start_bashp='herokup run bash'
alias start_bashs='herokus run bash'
alias start_bashi='herokui run bash'

# Heroku Specific
alias herokuplogs='herokup logs --tail'
alias herokuslogs='herokus logs --tail'
# $@ is all arguments, ${@:-22033} uses passed-in args or default 22033 
herokus() { heroku $@ --app cedar-appointmentcare-staging ; } 
herokup() { heroku $@ --app cedar-appointmentcare-prod ; } 
herokui() { heroku $@ --app cedar-appointmentcare-integ ; } 
# heroku pgbackups #display backups
# heroku pgbackups:capture --expire  #create newest DB, delete oldest BU
# heroku pgbackups:url [b350] #create URL for D/L
# curl -o stag_20130213.dmp <URL with quotes> #download heroku pgbackup dump from url
alias import_dump='pg_restore --verbose --clean --no-acl --no-owner -h localhost -U user1 -d appointmentcare_development' #pass in dump file, heroku pgbackups 

# General Linux
fa() { grep -i $1 ~/.bash_profile ; }  #find alias
alias ll='ls -al'
alias ltr='ls -ltr'
alias gs='git status'
alias gb='git branch'
alias gc='git checkout'
alias gp='git remote prune origin'
alias gmnff='git merge --no-ff'
alias gd='git diff'
alias gitk='gitk 2>/dev/null'  #temp fix for gitk on Mountain Lion
alias gl='git log -n 4'
alias gvim='mvim'
alias vi='mvim'
## Color settings for manpages in less 
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

### cool functions
weather(){ curl -s "http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml?query=${@:-22033}"|perl -ne '/<title>([^<]+)/&&printf "\x1B[0;34m%s\x1B[0m: ",$1;/<fcttext>([^<]+)/&&print $1,"\n"';}

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
            *)          echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
