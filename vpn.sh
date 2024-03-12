#!/bin/bash

# Source the configuration file
source config.cfg

# check if config is set with required values
if [ -z "$VPN_HOST" ]; then
    echo "Error: VPN_HOST is not set in the config file."
    exit 1
fi
if [ -z "$VPN_PASSCODE" ]; then
    echo "Error: VPN_PASSCODE is not set in the config file."
    exit 1
fi
if [ -z "$VPN_PASSWORD" ]; then
    echo "Error: VPN_PASSWORD is not set in the config file."
    exit 1
fi
if [ -z "$VPN_ID" ]; then
    echo "Error: VPN_ID is not set in the config file."
    exit 1
fi

HOST=$VPN_HOST
PASSCODE=$VPN_PASSCODE
PASSWORD=$VPN_PASSWORD
STAFF_ID=$VPN_ID
TOKEN=$(stoken tokencode -p $PASSCODE)
PIN=$PASSCODE$TOKEN

if [ -z "$TOKEN" ]; then
    echo "Error: TOKEN not generated. Please make sure you have installed stoken and do the necessary configuration."
    exit 1
fi

echo "HOST is: $HOST"

PS3='Please enter your choice: '
options=("VPN with tunneling" "Just VPN" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "VPN with tunneling")
            echo "Initiating VPN with tunneling. You may need to enter sudo password."
            
            printf "$PIN\n$PASSWORD" | sudo openconnect --user=$STAFF_ID $HOST -s "vpn-slice $VPN_SLICE_URL"
            break
            ;;
        "Just VPN")
            echo "Initiating VPN only. You may need to enter sudo password."
            
            printf "$PIN\n$PASSWORD" | sudo openconnect --user=$STAFF_ID $HOST
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
