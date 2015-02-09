#!/bin/sh 
# Sets up PATHs
#
echo "starting .profile which will set environment variables like PATH"

# export HOST="tbd"

# general path munging
PROJECT_PATH="$HOME/projects"
CELLAR_HOME="/usr/local/Cellar"

export EDITOR="/usr/local/bin/mate -w"

# Using http://www.jenv.be/ to manage multiple JDKs
# export PATH="$HOME/.jenv/bin:$PATH"
if which jenv > /dev/null; then eval "$(jenv init -)"; fi

# equivalent to MacPorts Installer path modification
export PATH="$PATH:/opt/local/bin:/opt/local/sbin:$HOME/bin"

# export CC=gcc
# export CXX=g++

# Java stuff
# export JAVA_HOME=/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK

export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"
alias jenv_set_java_home='export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"'

export PATH="$JAVA_HOME/bin:$PATH"

# export HOMEBREW_GITHUB_API_TOKEN=""


export MYSQL_HOME="/usr/local/mysql"
export PATH="$PATH:$MYSQL_HOME/bin"

# Node.js stuff
export NVM_DIR="$HOME/.nvm"
export NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist
# export NVM_SOURCE
# export PROFILE

export HASKELL_HOME="/Library/Haskell/current"
# Manage Scala versions using svm
# http://scala.masanorihashimoto.com/2014/04/how-to-install-the-scala-version-manager-on-your-mac/
export SCALA_HOME="$HOME/.svm/current/rt"

export GROOVY_HOME="$CELLAR_HOME/groovy/current"

# alias ant=/usr/bin/ant
export ANT_HOST_NAME=$HOST
export ANT_HOME="$CELLAR_HOME/ant/current"
export MAVEN_HOME="$CELLAR_HOME/maven/current"
export GRADLE_HOME="$CELLAR_HOME/gradle/current"

export SBT_OPTS="-XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256M"
export SBT_HOME="$CELLAR_HOME/sbt/current"

export NODE_HOME="$CELLAR_HOME/node/current"


export PLAY_HOME="$CELLAR_HOME/play/current"
export ACTIVATOR_HOME="$CELLAR_HOME/typesafe-activator/current"
# Tomcat stuff
export CATALINA_HOME="$CELLAR_HOME/tomcat/current"
export PATH="$PATH:$CATALINA_HOME/bin"

alias start_tomcat="$CATALINA_HOME/bin/catalina start"
alias stop_tomcat="$CATALINA_HOME/bin/catalina stop"

export CASSANDRA_HOME="$CELLAR_HOME/cassandra/current"
export ELASTICSEARCH_HOME="$CELLAR_HOME/elasticsearch/current"
export MONGODB_HOME="$CELLAR_HOME/mongodb/current"
export REDIS_HOME="$CELLAR_HOME/redis/current"
export RIAK_HOME="$CELLAR_HOME/riak/current"


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

# alias fdhy="pushd $PROJECT_PATH/src/fdhybris/hybris-commerce-suite-5.3.0.0/hybris/bin/platform"

MySQLCOM_HOME=/Library/StartupItems/MySQLCOM
alias start_mysql="sudo $MySQLCOM_HOME/MySQLCOM start"
alias stop_mysql="sudo $MySQLCOM_HOME/MySQLCOM stop"

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

echo "done with .profile"



