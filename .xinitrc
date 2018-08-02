#!/bin/sh

export PATH=$PATH:$HOME/bin
export ELECTRON_MIRROR=http://npm.taobao.org/mirrors/electron/
export EDITOR="vim"

export QPCPP=~/workspace/qpc-qpcpp
export QTOOLS=~/workspace/qpc-qtools

# XDG Bse Directory Specification
# XDG_DATA_DIRS
# XDG_CONFIG_DIRS
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.data
export XDG_CACHE_HOME=~/.cache
export XDG_RUNTIME_DIR=~/.runtime

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

redshift &
unclutter --root &

urxvtd &

mpd

xbindkeys

~/bin/mount_disk.sh
~/bin/key_custom.sh

#setxkbmap -option ctrl:swapcaps

xset -b
#sxhkd&
#exec bspwm
exec awesome
