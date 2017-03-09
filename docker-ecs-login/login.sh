#!/bin/sh

# Purpose: Take the login info generated by 'docker login' and put it
# into ECS.  This requires cooredination to restar the ecs agent

file=/etc/ecs/ecs.config

base="$(dirname $0)/base-login.sh"

if [ -x "$base" ] ; then
    if ! "$base" "$@"  ; then
	echo "Failed to run base login"
	exit 1
    fi
fi

auth=$(cat ~/.docker/config.json | tr -d '\n' | sed -e 's/[ \t]\+/ /g')

if [ -w $file ] ; then
    (
	cat $file | grep -v ECS_ENGINE_AUTH
	echo 'ECS_ENGINE_AUTH_TYPE=dockercfg'
	echo "ECS_ENGINE_AUTH_DATA=$auth"
    ) > $file.new && mv -f $file.new $file
    echo "Updating $file to include new auth data"
else
    echo "$file not writable.  Not updating"

fi
