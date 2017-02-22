#!/bin/sh
echo "Running $* for every change in /monitor"

find /monitor -type f -print0 | xargs -0 -r "$@"

inotifywait -r -m -e modify /monitor | 
   while read path _ file; do 
       if [ -z "$@" ] ; then 
	   echo $path$file modified
       else
	   "$@" "$path$file"
       fi
   done