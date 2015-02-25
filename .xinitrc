#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
#ibus-daemon -x &

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrdb -merge ~/.Xresources
#keynav&
/usr/bin/VBoxClient-all

 exec awesome
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
