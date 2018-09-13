#!/bin/sh

HOME_T480s="a0:c5:89:a6:c5:70"
HOME_T410="xxxxxxxxx"

# get physical wireless mac addr to identify the specific machine
PHY_ADDR=`iw dev |grep addr | tail -n 1 |awk '{print $2}'`

case "${PHY_ADDR}" in
    ${HOME_T480s})
        echo "This machine is t480s"
        ;;

    *)
        echo "unkown machine"
        ;;
    esac