#!/bin/bash

source_folder=/mnt/c/Users/Charles/Desktop/Bash-in-Action
target_folder=/mnt/e/Bash-in-Action

rsync -a ${source_folder} ${target_folder}

if [ $? -gt 0 ]
then
    echo "failure"
else
    echo "pass"
fi