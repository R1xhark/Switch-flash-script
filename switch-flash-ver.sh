#!/bin/bash

echo "Switch Flash script"
echo "Input 'k' to exit"

while true; do
    read p "Enter Switch SN: " sn
    read -p "Enter Switch IP: " ip
    
    is_unit_up(){
    ping -c 1 "$1" &> /dev/null
    return $?
}

if screen -ls | grep -q ".*$sn*."; then
    echo "Switch Flash already in progress."
else
    if is_unit_up "ip"; then

    if [[ "$ip" == 'k' || "$sn" == 'k' ]]; then
        echo "Exiting the script."
        exit 0
    fi

    check=$(ssh "$ip" cat /etc/lsb-release)

    if [[ -n "$sn" && -n "$ip" ]]; then
        if [[ "$sn" == *"8260"* ]]; then
            if echo "$check" | grep -q '^DISTRIB_RELEASE=2017\.11\.020\.amzn$'; then
                echo "Switch is already flashed."
            else
                echo "Flashing CS8260-32X-DC-11 switch."
                screen -dmS "$sn" bash -c "bash /home/C2111004/remote_switch_flash_c8260.sh $ip"
            fi
        elif [[ "$sn" == *"8060"* ]]; then
            if echo "$check" | grep -q '^DISTRIB_RELEASE=2017\.11\.09$'; then
                echo "Switch is already flashed."
            else
                echo "Flashing AS8060-32X-DC-11 switch."
                screen -dmS "$sn" bash -c "bash /home/C2111004/remote_switch_flash_as.sh $ip"
            fi
        elif [[ "$sn" == *"8000"* ]]; then
            if echo "$check" | grep -q '^DISTRIB_RELEASE=2017\.11\.151$'; then
                echo "Switch is already flashed."
            else
                echo "Flashing CS8000-32X-DC-11 switch."
                screen -dmS "$sn" bash -c "bash /home/C2111004/remote_switch_flash_cs.sh $ip"
            fi
        else
            echo "Error: Invalid SN: $sn or IP: $ip."
        fi
    else
        echo "Both IP and SN must be provided."
    fi

    read -p "Do you want to enter another switch? (Y/N): " choice
    if [[ "$choice" != "Y" && "$choice" != "y" ]]; then
        echo "Exiting the script."
        exit 0
    fi
done
