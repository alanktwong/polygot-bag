#!/bin/sh
# -----------------------------------------------------------------------------
# Convenience script for Maven and/or Ant
#
# @author awong
# -----------------------------------------------------------------------------

WORKING_DIR=`pwd`

if [ "$1" = "compile" ] ; then
    mvn -Parvlocal clean install -DskipTests=true
elif [ "$1" = "all" ] ; then
    mvn -Parvlocal clean install -DskipTests=true
    echo ""
    echo ""
    echo "----------------------------------------------------------------------"
    echo "Copying target artifact to Tomcat"
    cp $WORKING_DIR/adidasweb/target/adidasweb.war $CATALINA_HOME/webapps
    echo "----------------------------------------------------------------------"
    ls -alwG $CATALINA_HOME/webapps | grep 'war'
elif [ "$1" = "version" ] ; then
    mvn --version
else

  echo "Usage: build.sh ( commands ... )"
  echo "commands:"
  echo "  compile           Clean/install of artifacts only"
  echo "  all               Clean, rebuild and then deploy artifacts to Tomcat local directory"
  echo "  version           What version of ant and/or maven are you running?"
  exit 1

fi