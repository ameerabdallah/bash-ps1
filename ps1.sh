# Bash Colors
RESTORE='\033[0m'

RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
LIGHTGRAY='\033[00;37m'

LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'

# Source git_prompt
source ~/.git-prompt.sh

# Bash Prompt (PS1)
function changes_in_branch() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if expr "$(git status -s)" 2>&1 > /dev/null; then
            echo -ne "\033[0;33m$(__git_ps1)\033[0m";
        else
            echo -ne "\033[0;32m$(__git_ps1)\033[0m";
	fi;
    fi
}

function get_git_ahead() {
    local LGREEN='\033[01;32m'
    value=$(git log @{u}..HEAD --oneline 2> /dev/null | wc -l | xargs)
    if [[ ! "0" == "$value" ]]; then
        value="+$value "
    else
        value=""
    fi
    echo "$value" 
}

function get_git_behind() {
    local LRED='\033[01;31m'
    value=$(git log HEAD..@{u} --oneline 2> /dev/null | wc -l | xargs)
    if [[ ! "0" == "$value" ]]; then
        value="-$value "
    else
        value=""
    fi
    echo "$value"
}

# bash prompt
PS1="\[${LRED}\]\u"
PS1+="\[${LIGHTGRAY}\]:"
PS1+="\[${LCYAN}\]\w"
PS1+="\[${LGREEN}\]\$(changes_in_branch) "
PS1+="\[${LRED}\]\$(get_git_behind)"
PS1+="\[${LGREEN}\]\$(get_git_ahead)"
PS1+="\n\[$(tput sgr0)\]\[${LGREEN}\]└─"
PS1+=" \[${LYELLOW}\]\$\[$(tput sgr0)\] "
export PS1
