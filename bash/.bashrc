
# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# -------------------------------------------------------------------
# misc preferences
alias l='/bin/ls --color=auto -rtl'
function mkcd { mkdir -p "${1?}" && cd "$1" ; }
export EDITOR=vim

export PATH=$PATH:$HOME/bin

umask 027

# -------------------------------------------------------------------
# git
source /usr/share/doc/git-"$(git --version|awk '{print $NF}')"/contrib/completion/git-completion.bash 2>/dev/null
alias d='git diff'
alias s='git status -s'
alias b='git branch -avv'
alias lg='git lg'
alias rem='git remote -v'

# -------------------------------------------------------------------
# history
export HISTSIZE=10000
export HISTCONTROL=ignoredups
export HISTTIMEFORMAT='%Y%m%d-%H:%M:%S '

# -------------------------------------------------------------------
# python
# check in common directories for locally installed python versions
for pydir in 27 2.7 34 3.5 35 3.5 ; do
    [[ -d /usr/local/python${pydir} ]] && {
        export PATH=/usr/local/python${pydir}/bin:$PATH
        break
    }
done

# python virtualenvwrapper
# http://www.doughellmann.com/docs/virtualenvwrapper/
if [ -f $(which virtualenvwrapper.sh) ] ; then
    export WORKON_HOME=$HOME/virtualenv
    export VIRTUALENVWRAPPER_PYTHON=$(which python)
    export PROJECT_HOME=$HOME/sb
    source $(which virtualenvwrapper.sh)
fi

# -------------------------------------------------------------------
#  prompt
YELLOW="\[\033[0;33m\]"
RED="\[\033[0;31m\]"
BOLDRED="\[\033[1;31m\]"
BLUE="\[\033[0;34m\]"
GREEN="\[\033[0;32m\]"
TEAL="\[\033[0;36m\]"
RESET="\[\033[0m\]"

# /usr/share/doc/git-1.7.1/contrib/completion/git-completion.bash
export GIT_PS1_SHOWDIRTYSTATE=1

# based on
# https://github.com/couchand/dotfiles/blob/master/.bashrc
function parse_git_branch {
  git rev-parse --git-dir &> /dev/null || return
  git_status="$(git status 2> /dev/null)"
  if [[ $(git --version) =~ "2." ]] ; then
    # git v2
    branch_pattern="^On branch ([^${IFS}]*)"
    changed_files="Changes not staged"
    added_files="Changes to be committed"
  else
    # git v1.7
    branch_pattern="^# On branch ([^${IFS}]*)"
    changed_files="Changed but not updated"
    added_files="Changes to be committed"
  fi

  if [[ ${git_status} =~ "Your branch is up-to-date" ]]; then
    state="${BLUE}"
  else
    state="${BOLDRED}"
  fi

  if [[ ${git_status} =~ $added_files && ${git_status} =~ $changed_files ]]; then
    extra="${YELLOW}+"
  elif [[ ${git_status} =~ $added_files ]]; then
    extra="${GREEN}+"
  elif [[ ${git_status} =~ $changed_files ]]; then
    extra="${RED}+"
  else
    extra=""
  fi

  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
    echo " ${BLUE}(${state}${branch}${extra}${BLUE})"
  fi
}

function prompt_func {
  PS1="${VIRTUAL_ENV:+(${VIRTUAL_ENV##*/})}${TEAL}\u@\h ${YELLOW}\w${RESET}$(parse_git_branch)${RESET} \$ "
}

export PROMPT_DIRTRIM=3
PROMPT_COMMAND=prompt_func

# -------------------------------------------------------------------
