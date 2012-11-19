#!/bin/sh 
# Sets up PATHs
#

# general path munging
PROJECT_PATH=$HOME/projects

# equivalent to MacPorts Installer path modification
export PATH="$PATH:/opt/local/bin:/opt/local/sbin:$HOME/bin"

# export CC=gcc
# export CXX=g++

# Java stuff

# export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK

# Ant stuff
# alias ant=/usr/bin/ant
# export ANT_HOST_NAME=blaugrana
# export ANT_HOME=/usr/share/java/ant-1.0.2

# Maven stuff
# export MAVEN_HOME=/usr/share/java/maven-3.0.3

# Tomcat stuff
# export TOMCAT_HOME=/usr/local/apache-tomcat-7.0.29
# export TOMCAT_HOME=/usr/local/apache-tomcat-6.0.35

# MySQL stuff
# export MYSQL_HOME=/usr/local/mysql
# PATH=${JAVA_HOME}/bin:${PATH}:/usr/local/mysql/bin:/usr/local/ant-1.6.5/bin

# jRuby stuff
# export JRUBY_HOME=$HOME/projects/bin/jruby-0.9.2
# PATH=${PATH}:$JRUBY_HOME/bin

# Oracle stuff for Novation
export ORACLE_IC_HOME="/usr/local/oracle/instantclient_10_2"
export ORACLE_HOME="$ORACLE_IC_HOME"
export TNS_ADMIN="$ORACLE_IC_HOME"

export PATH="$PATH:$ORACLE_IC_HOME"

export LD_LIBRARY_PATH="$ORACLE_IC_HOME"
export DYLD_LIBRARY_PATH="$ORACLE_IC_HOME"
export CLASSPATH="$ORACLE_IC_HOME/ojdbc14.jar:./"

# postgres
# export PATH=${PATH}:/usr/local/pgsql/bin
# export PGDATA=/usr/local/pgsql/data

# GEOS_DIR
# export GEOS_DIR=/opt/local/lib/geos-3.3.1

#-----#
# X11 #
#-----#
export DISPLAY=:0.0
export PATH="$PATH:/usr/X11R6/bin"



# Use python virtual environment
export PYTHON_LIB="/Library/Frameworks/Python.framework/Versions/Current/lib/python2.7"
export PYTHON_PACKAGES="$PYTHON_LIB/site-packages"
export PYTHON_VENV="$PROJECT_PATH/bin/python_venv/epd"
#
# modify Python's sys.path 
#
#  append $PYTHON_VENV_PACKAGES/basemap-1.0.2/lib
export PYTHONPATH="$PYTHON_VENV/lib/python2.7/site-packages:$PYTHON_PACKAGES:$PYTHONPATH"
#
# following bash script ensures python in virtualenv always takes precedence
# To ensure that we can run python scripts from the command line
# add unix link at /opt/local/sbin/python to version of python named in activate script
# Prepend all python scripts with this.
#
source $PYTHON_VENV/bin/activate




