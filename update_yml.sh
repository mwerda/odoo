#!/bin/bash

if [[ -f "./environment.sh" ]]; then
    source environment.sh
fi

export ADDONS_PATH=$(awk -vORS=, '{ print $1 }' addons_path.conf | sed 's/,$/\n/')

# Get new list of portals
    envsubst < ./setupfiles/docker-compose.tpl > docker-compose.yml
