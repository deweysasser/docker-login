#!/bin/sh
echo "Running $* for every change in /monitor"

find /monitor -type f -print0 | xargs -0 -r "$@"

inotifywait -m -e modify /monitor | 
   while read path _ file; do 
       base=$(basename $file .txt)
       if [ -z "$@" ] ; then 
	   echo $path$file modified
       elif [ -x "/root/$base.sh" ] ; then
	       "$@" "$path$file"
       else
	   echo "No file /root/$base.sh to handle changes in $path$file"
       fi
   done