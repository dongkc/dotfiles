#!/bin/sh
custom_keys () {
    # change capsLock to Left Ctrl
    setxkbmap -option ctrl:nocaps

    # from xcap manual
    spare_modifier="Hyper_L"
    xmodmap -e "keycode 36 = $spare_modifier"
    xmodmap -e "remove mod4 = $spare_modifier"
    # hyper_l is mod4 by default
    xmodmap -e "add Control = $spare_modifier"
    xmodmap -e "keycode any = Return"
    xcape -e "$spare_modifier=Return;Control_L=Escape"
    # set left ctrl to escape
    # xcape
}

disable_touchpad() {
    # locate the Touchpad device number
    TOUCHPAD=`xinput list | grep Touchpad | awk '{print $6}' | awk -F= '{print $2}'` 
    xinput --disable $TOUCHPAD
}

HOME_T480s="a0:c5:89:a6:c5:70"
HOME_T410="58:94:6b:1a:84:20"
WORK_DELL="34:02:86:61:e7:70"

# get physical wireless mac addr to identify the specific machine
PHY_ADDR=`iw dev |grep addr | tail -n 1 |awk '{print $2}'`

case "${PHY_ADDR}" in
    ${HOME_T480s})
        echo "This machine is t480s"
        custom_keys
        disable_touchpad
        ;;

    ${HOME_T410})
        echo "This machine is t410"
        custom_keys
        disable_touchpad
        ;;

    ${WORK_DELL})
        echo "This machine is work dell"
        # make the left ctrl key and return key to double function, using xcap to do this
        #custom_keys
        # echo disable > /sys/firmware/acpi/interrupts/gpe27

        # mount the sata disk inside the dell laptop
        sudo mount /dev/sda2 /mnt/hd
        sudo mount /dev/sda4 /mnt/usb
        sudo mount /dev/sda5 /mnt/code
        sudo mount /dev/sda6 /mnt/doc

	# setup dual monitors
        xrandr --output DP1-3 --auto --output eDP1 --auto --left-of DP1-3
        ;;

    *)
        echo "unkown machine"
        ;;
esac
