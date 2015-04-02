#!/bin/bash
# =====================================
# Cygwin bash profile.
# Configure to your liking.
# =====================================
. ~/.bash_profile

# Disable DOS path warnings
export CYGWIN=nodosfilewarning

# Command aliases
alias mci="mvn clean install"
alias mcp="mvn clean package"