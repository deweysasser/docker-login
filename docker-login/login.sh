#!/bin/sh

sed -n '/^[ \t]$/d; s/#.*//; /./p' "$@" | while read LINE; do
    docker login $LINE
done
