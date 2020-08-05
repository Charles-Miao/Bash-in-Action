#/bin/bash

size=`df -h / | grep / | awk '{print ($5)}'| sed 's/%//g'`

echo ${size}

if [ $size -gt 60 ]
then
    echo '/ usage has exceeded 60% '
else
    echo '/ usage has not exceeded 60%'
fi
