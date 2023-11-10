#!/bin/bash

is_unit_up() {
    ping -c 1 "$1" &> /dev/null
    return $?
}

while true; do
    echo "Switch Flash script"
    echo "Input 'k' to exit"

    read -p "Enter Switch SN:" sn
    read -p "Enter Switch IP:" ip

    if [[ "$sn" == 'k' || "$ip" == 'k' || "$sn" == 'K' || "$sn" == 'K' ]]; then
        exit 0
    fi

    if screen -ls | grep -q "*.$sn.*"; then
        echo "Switch Flash already in progress."
    else
        if is_unit_up "$ip" && [ -n "$sn" ] && [ -n "$ip" ]; then
            check=$(ssh "$ip" cat /etc/lsb-release)

            if [[ "$sn" == *"8260"* ]]; then
                if echo "$check" | grep -q '^DISTRIB_RELEASE=2017\.11\.020\.amzn$'; then
                    echo "Switch is already flashed."
                else
                    echo "Flashing CS8260-32X-DC-11 switch"
                    screen -dmS "$sn" bash -c "bash /home/C2111004/remote_switch_flash_c8260.sh $ip"
                fi
            elif [[ "$sn" == *"8060"* ]]; then
                if echo "$check" | grep -q '^DISTRIB_RELEASE=2017\.11\.09$'; then
                    echo "Switch is already flashed."
                else
                    echo "Flashing AS8060-32X-DC-11 switch"
                    screen -dmS "$sn" bash -c "bash /home/C2111004/remote_switch_flash_as.sh $ip"
                fi
            elif [[ "$sn" == *"8000"* ]]; then
                if echo "$check" | grep -q '^DISTRIB_RELEASE=2017\.11\.151$'; then
                    echo "Switch is already flashed."
                else
                    echo "Flashing CS8000-32X-DC-11 switch"
                    screen -dmS "$sn" bash -c "bash /home/C2111004/remote_switch_flash_cs.sh $ip"
                fi
            else
                echo "Error: SN $sn not valid."
            fi

            read -p "Do you want to enter another IP? (Y/N):" choice
            if [[ "$choice" != "Y" && "$choice" != "y" ]]; then
                exit 0
            fi
        else
            echo "Unit is offline or SN/IP input is missing."
        fi
    fi
done
