#!/bin/bash
#
# (c) michael.wellner@de.ibm.com 2016.
#
# This script cleans docker environment.
# 
# Usage:
# docker-clean.sh [ -h | --help | OPTIONS ]
#

# Fail if one of the commands fails
set -e

CURRENTDIR=`pwd`
BASEDIR=$(dirname $0)


main() {
  cd ${BASEDIR} 
  read_variables "$@"
  
  docker ps -a | grep 'Exited' | grep -v 'build-dvc' | awk '{print $1}' | xargs docker rm -v  || true
  docker images | grep "<none>" | awk '{print $3}' | xargs docker rmi || true
  docker volume ls | grep local | awk '{print $2}' | xargs docker volume rm || true
  
  cd ${CURRENTDIR}
}

read_variables() {
  while [[ $# -gt 0 ]]
  do
    key="$1"
    case $key in
      -h|--help)
        show_help_and_exit 0;;
      *)
        >&2 echo "Unkown option $1 with value $2."
        echo
        show_help_and_exit 2
        ;;
    esac
  done
}

show_help_and_exit() {
  echo "This script cleans docker environment."
  echo ""
  echo "Usage:"
  echo "docker-clean.sh [ -h | --help | OPTIONS ]"
  echo
  sleep 3
  
  cd ${CURRENTDIR}
  exit $1
}


main "$@"
