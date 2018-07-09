#!/bin/bash
# =====================================
# Cygwin bash profile.
# Configure to your liking.
# =====================================
. ~/.bash_profile

# Disable DOS path warnings
export CYGWIN=nodosfilewarning

# Command aliases
alias ..="cd .."
alias ...="cd ../.."
alias dir="ls -alF --color=auto"
alias mci="mvn clean install"
alias mcp="mvn clean package"
alias start="cmd /c start"

################## START GIT PROMPT ##############################
RED="\033[0;31m"
GREEN="\033[0;32m"
ORANGE="\033[1;31m"
YELLOW="\033[0;33m"
MAGENTA="\033[0;35m"
CYAN="\033[0;36m"
PURPLE="\033[1;35m"
DARK="\033[1;32m"
DEFAULT="\033[1;32m"
MEDIUM="\033[1;33m"
LIGHT="\033[1;34m"
WHITE="\033[1;37m"

RESET="\033[m"

function git_info() {
  # check if we're in a git repo
  git rev-parse --is-inside-work-tree &>/dev/null || return

  # quickest check for what branch we're on
  local branch=$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')

  # check if it's dirty (via github.com/sindresorhus/pure)
  local dirty=$(git diff --quiet --ignore-submodules HEAD &>/dev/null; [ $? -eq 1 ] && echo -e "*")

  echo -e "${RESET}on ${GREEN}$branch ${RED}$dirty"
}

# window title
PS1='\[\033]0;\W\007\]'

# prompt title
PS1="$PS1\n${ORANGE}\u@\h ${RESET}in ${YELLOW}\w \$(git_info) ${RESET}"

# default interaction prompt
PS1="$PS1\n\[$LIGHT\]\$ \[$RESET\]"

# continuation interactive prompt
PS2="${WHITE}→ ${RESET}"
