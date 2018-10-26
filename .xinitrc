#!/bin/sh

# Make ~/.bar folder executable
export PATH="${PATH}:$HOME/.bar"

# Make ~/.toys folder executable
export PATH="${PATH}:$HOME/.toys"

# Make ~/.utility folder executable
export PATH="${PATH}:$HOME/.utility"

# Make ~/.notify folder executable
export PATH="${PATH}:$HOME/.notify"

# Make ~/.notify folder executable
export PATH="${PATH}:$HOME/.executor"

export PATH="${PATH}:/usr/sbin:/sbin"

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
[ -f $sysresources ] && xrdb -merge $sysresources
[ -f $sysmodmap ] && xmodmap $sysmodmap
[ -f $userresources ] && xrdb -merge $userresources
[ -f $usermodmap ] && xmodmap $usermodmap

sxhkd &

# Start the window manager:
if [ -z "$DESKTOP_SESSION" -a -x /usr/bin/ck-launch-session ]; then
  ck-launch-session dbus-launch --exit-with-session bspwm
else
  bspwm
fi

