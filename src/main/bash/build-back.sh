#!/bin/sh
# -----------------------------------------------------------------------------
# Convenience script for Maven and/or Ant
#  
# @author awong
# -----------------------------------------------------------------------------

WORKING_DIR=`pwd`

if [ "$1" = "compile" ] ; then
    ant clean all
    ant
elif [ "$1" = "init" ] ; then
    ant initialize
elif [ "$1" = "populate" ] ; then
    ant fixturedata sampledata
elif [ "$1" = "start" ] ; then
    ./hybris/bin/platform/hybrisserver.sh debug
elif [ "$1" = "version" ] ; then
    ant -version
else

    echo "Usage: build.sh ( commands ... )"
    echo "commands:"
    echo "  compile           Clean and rebuild Hybris backend"
    echo "  init              Refresh DB used by Hybris backend (depends on compile)"
    echo "  populate          Populate DB used by Hybris backend (depends on init)"
    echo "  start             Start Hybris backend"
    echo "  version           What version of Ant are you running?"
    exit 1
fi