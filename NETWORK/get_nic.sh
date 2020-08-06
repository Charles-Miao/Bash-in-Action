#/bin/bash

get_IP(){
    ip=`ifconfig $1 | grep "inet " |awk -F" " '{print $2}'`
    echo ${ip}
}

get_MAC(){
    mac=`ifconfig $1 | grep "ether" | awk -F " " '{print $2}'`
    echo ${mac}
}

reachable(){
    reachable=0
    ip=`ifconfig $1 | grep "inet " |awk -F" " '{print $2}'`
    ping_result=`ping $ip -c 1 | grep "1 packets transmitted, 1 received, 0% packet loss, time 0ms"`
    if [ "$ping_result" == "1 packets transmitted, 1 received, 0% packet loss, time 0ms" ]
    then
        reachable=1
    else
        reachable=0
    fi
    echo ${reachable}
}

echo $1 IP: `get_IP $1`
echo $1 MAC: `get_MAC $1`
echo $1 reachable: `reachable $1`