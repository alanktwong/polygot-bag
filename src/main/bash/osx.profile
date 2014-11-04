#!/bin/sh 
# Sets up PATHs
#

export HOST="messi"
# general path munging
PROJECT_PATH=$HOME/projects

# equivalent to MacPorts Installer path modification
export PATH="$PATH:/opt/local/bin:/opt/local/sbin:$HOME/bin"

# export CC=gcc
# export CXX=g++

# Java stuff
# export JAVA_HOME=/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_71.jdk/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"

# MySQL stuff
export MYSQL_HOME=/usr/local/mysql
export PATH="$PATH:$MYSQL_HOME/bin"

# Node.js stuff
export NVM_DIR="$HOME/.nvm"
export NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist
# export NVM_SOURCE
# export PROFILE

# Scala stuff
export SCALA_HOME="$PROJECT_PATH/bin/scala/current"
export PATH="$PATH:$SCALA_HOME/bin"

# Groovy stuff
export GROOVY_HOME="$PROJECT_PATH/bin/groovy/current"
export PATH="$PATH:$GROOVY_HOME/bin"

# Ant stuff
# alias ant=/usr/bin/ant
export ANT_HOST_NAME=$HOST
export ANT_HOME="$PROJECT_PATH/bin/ant/current"
export PATH="$PATH:$ANT_HOME/bin"

# Maven stuff
export MAVEN_HOME="$PROJECT_PATH/bin/maven/current"
export PATH="$PATH:$MAVEN_HOME/bin"

# Maven stuff
export GRADLE_HOME="$PROJECT_PATH/bin/gradle/current"
export PATH="$PATH:$GRADLE_HOME/bin"

# SBT stuff
export SBT_HOME="$PROJECT_PATH/bin/sbt/current"
export PATH="$PATH:$SBT_HOME/bin"

# Tomcat stuff
export TOMCAT_HOME="$PROJECT_PATH/bin/tomcat/current"
export PATH="$PATH:$TOMCAT_HOME/bin"


# jRuby stuff
# export JRUBY_HOME=$HOME/projects/bin/jruby-0.9.2
# PATH=${PATH}:$JRUBY_HOME/bin

# Oracle stuff for Novation
# export ORACLE_IC_HOME="/usr/local/oracle/instantclient_10_2"
# export ORACLE_HOME="$ORACLE_IC_HOME"
# export TNS_ADMIN="$ORACLE_IC_HOME"


# export PATH="$PATH:$ORACLE_IC_HOME"

# export LD_LIBRARY_PATH="$ORACLE_IC_HOME"
# export DYLD_LIBRARY_PATH="$ORACLE_IC_HOME"
# export CLASSPATH="$ORACLE_IC_HOME/ojdbc14.jar:./"

# postgres
# export PATH=${PATH}:/usr/local/pgsql/bin
# export PGDATA=/usr/local/pgsql/data

# GEOS_DIR
# export GEOS_DIR=/opt/local/lib/geos-3.3.1

# ----------------------------------------------------------------------------
# quick change for projects
# ----------------------------------------------------------------------------
alias src="pushd $PROJECT_PATH/src"
alias doc="pushd $PROJECT_PATH/doc"

alias fdhy="pushd $PROJECT_PATH/src/fdhybris/hybris-commerce-suite-5.3.0.0/hybris/bin/platform"

alias start_mysql="sudo /Library/StartupItems/MySQLCOM/MySQLCOM start"
alias stop_mysql="sudo /Library/StartupItems/MySQLCOM/MySQLCOM stop"

#-----#
# X11 #
#-----#
export DISPLAY=:0.0
export PATH="$PATH:/usr/X11R6/bin"


# Use python virtual environment
# export PYTHON_LIB="/Library/Frameworks/Python.framework/Versions/Current/lib/python2.7"
# export PYTHON_PACKAGES="$PYTHON_LIB/site-packages"
# export PYTHON_VENV="$PROJECT_PATH/bin/python_venv/epd"
#
# modify Python's sys.path 
#
#  append $PYTHON_VENV_PACKAGES/basemap-1.0.2/lib
# export PYTHONPATH="$PYTHON_VENV/lib/python2.7/site-packages:$PYTHON_PACKAGES:$PYTHONPATH"
#
# following bash script ensures python in virtualenv always takes precedence
# To ensure that we can run python scripts from the command line
# add unix link at /opt/local/sbin/python to version of python named in activate script
# Prepend all python scripts with this.
#
# source $PYTHON_VENV/bin/activate




