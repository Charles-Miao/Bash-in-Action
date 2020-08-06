#/bin/bash
#nic_name=`ls /sys/class/net`
nic_name=(`ifconfig | grep "flags" | awk -F ":" '{print $1}'`)

for loop in ${nic_name[*]}
do
    source get_nic.sh ${loop}
done