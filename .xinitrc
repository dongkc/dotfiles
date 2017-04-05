#!/bin/sh

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
fcitx

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrdb -merge ~/.Xresources

~/bin/am
keynav &
redshift &
pulseaudio --start
unclutter &
mpd

cd ~/.config/remind && \
remind -z1 '-knotify-send -u critical "-------- 事件提醒 --------" %s &'  ~/.config/remind/remind.conf &

#setxkbmap -option ctrl:swapcaps

xset -b
exec awesome
