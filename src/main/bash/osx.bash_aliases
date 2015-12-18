#!/bin/sh 
# Sets up aliases
#
echo "setting aliases with .bash_aliases"

#===============================================================
#
# ALIASES AND FUNCTIONS
#
# Arguably, some functions defined here are quite big.
# If you want to make this file smaller, these functions can
# be converted into scripts and removed from here.
#
# Many functions were taken (almost) straight from the bash-2.04
# examples.
#
#===============================================================
alias reload="source $HOME/.bashrc"
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# -> Prevents accidentally clobbering files.
alias mkdir='mkdir -p'

alias h='history'
alias j='jobs -l'
alias ..='cd ..'
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

# alias print='/usr/bin/lp -o nobanner -d $LPDEST'  # Assumes LPDEST is defined (default printer)
# alias pjet='enscript -h -G -fCourier9 -d $LPDEST' # Pretty-print using enscript

alias du='du -kh'       # Makes a more readable output.
alias df='df -kTh'


alias grep="grep -i --color=auto"
alias fgrep="fgrep -i -n -r --color=auto"
alias less="less -r"
alias more="more -r"

alias pu='pushd'
alias po='popd'

# the "kp" alias ("que pasa"), in honor of tony p.
alias kp="ps auxwww"


alias ls='ls -hFG'         # add colors for filetype recognition
alias ll='ls -alwG'
alias lp='ls -p'
alias la='ls -Al'          # show hidden files
alias lx='ls -lXB'         # sort by extension
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -al | more'   # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias tree='tree -Csu'     # nice alternative to 'recursive ls'

# ----------------------------------------------------------------------------
# quick change for projects
# ----------------------------------------------------------------------------
echo "starting convenience aliases for project work"

export PROJECTS_SRC="$PROJECTS/src"
alias src="pushd $PROJECTS/src"
export PROJECTS_DOC="$PROJECTS/doc"
alias doc="pushd $PROJECTS/doc"
export PROJECTS_LIB="$PROJECTS/lib"
alias lib="pushd $PROJECTS/lib"


export TRAILS_HOME="$PROJECTS_SRC/hybris-demo"
alias trails="pushd $TRAILS_HOME/5.5.0.0/hybris/bin/platform"
alias trails-oms="pushd $TRAILS_HOME/hybris-trails/merchandise-oms/oms-ext"
alias trails-repo="pushd $TRAILS_HOME/hybris-trails"


alias fdhy="pushd $PROJECTS_SRC/fdhybris/hybris-commerce-suite-5.3.0.0/hybris/bin/platform"

export ANA_HOME="$PROJECTS_SRC/alexAndAni"
alias ana="pushd $ANA_HOME"
export ANA_VM="$ANA_HOME/ana-vm"
alias ana-vm="pushd $ANA_VM/vm"
alias ana-hy="pushd $ANA_VM/codebase/ana-hybris"
alias ana-hy-local="pushd $ANA_HOME/5.5.0.0/hybris/bin/platform"

export DY_HOME="$PROJECTS_SRC/davidYurman"
alias dy="pushd $DY_HOME"
export DY_VM="$DY_HOME/dy-vm"
alias dy-vm="pushd $DY_VM/vm"
alias dy-hy="pushd $DY_HOME/5.1.1/hybris/bin/platform"
alias dy-codebase="pushd $DY_VM/codebase"
alias dy-aem="pushd $DY_VM/codebase/content"

export COURSERA_HOME="$PROJECTS_SRC/coursera-work"
alias coursera="pushd $COURSERA_HOME"
export REACTIVE_HOME="$COURSERA_HOME/reactive/"
alias reactive="pushd $REACTIVE_HOME"

alias start_mysql="sudo $MYSQL_HOME/support-files/mysql.server start"
alias stop_mysql="sudo $MYSQL_HOME/support-files/mysql.server stop"
