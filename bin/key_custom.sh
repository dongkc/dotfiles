#!/bin/sh

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
