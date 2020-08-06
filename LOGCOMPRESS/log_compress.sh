#!/bin/sh

source_folder='/mnt/c/Users/Charles/Desktop/log'
target_folder='/mnt/c/Users/Charles/Desktop/log_compress'

for files in `ls $source_folder`
do 
    # tar -cPf ${target_folder}/${files}.tar ${source_folder}/${files}
    # gzip ${target_folder}/${files}.tar
    tar -czPf ${target_folder}/${files}.tar.gz ${source_folder}/${files}
done