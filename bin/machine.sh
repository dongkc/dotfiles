#!/bin/sh

HOME_T480s="a0:c5:89:a6:c5:70"
HOME_T410="58:94:6b:1a:84:20"
WORK_DELL="00000000"

# get physical wireless mac addr to identify the specific machine
PHY_ADDR=`iw dev |grep addr | tail -n 1 |awk '{print $2}'`

case "${PHY_ADDR}" in
    ${HOME_T480s})
        echo "This machine is t480s"
        ;;

    ${HOME_T410})
        echo "This machine is t410"
        ;;

    ${WORK_DELL})
        echo "This machine is work dell"
        ;;

    *)
        echo "unkown machine"
        ;;
    esac