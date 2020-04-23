#!/bin/bash

monitor_dir=~/automation

files=$(find "$monitor_dir" -maxdepth 1 | sort)

while true
do
  sleep 5s

  newfiles=$(find "$monitor_dir" -maxdepth 1 | sort)
  added=$(comm -13 < "(echo $files)" < "(echo $newfiles)" )
  echo "Added is:"$added"\n"

  [ "$added" != "" ] &&
    find $added -maxdepth 1 -printf '%Tc\t%s\t%p\n'

  files="$newfiles"
done
