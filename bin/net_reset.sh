#!/bin/sh
IF=`nmcli c show --active |grep wifi |awk '{print $1}'`
echo $IF

sudo nmcli c down $IF && sudo nmcli c up $IF
