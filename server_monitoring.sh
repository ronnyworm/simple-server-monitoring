#!/bin/bash

# run me with sudo because of the service checks (and gem install mail)

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$SCRIPT_DIR/funcs.sh"
printf "start test $(date +"%Y-%m-%d %H:%M:%S")\n"

source "$1"

wait
echo "done"

