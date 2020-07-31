#!/bin/bash

source_folder=/mnt/c/Users/Charles/Desktop/Bash-in-Action
target_folder=/mnt/e/Bash-in-Action

rsync -a --delete --exclude-from=exclude.list ${source_folder} ${target_folder}

if [ $? -gt 0 ]
then
    echo "Some errors occurred while synchronizing files" > logging.log
else
    echo "Synchronization file successful" > logging.log
fi