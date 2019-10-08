#!/bin/sh

# Make ~/.bar folder executable
export PATH="${PATH}:$HOME/.bar"

# Make ~/.toys folder executable
export PATH="${PATH}:$HOME/.toys"
export PATH="${PATH}:$HOME/bin"

# Make ~/.utility folder executable
export PATH="${PATH}:$HOME/.utility"

# Make ~/.notify folder executable
export PATH="${PATH}:$HOME/.notify"

# Make ~/.notify folder executable
export PATH="${PATH}:$HOME/.executor"

export PATH="${PATH}:/usr/lib64/go1.11/go/bin"

export PATH="${PATH}:/opt/java/jre1.8.0_191/bin"

export PATH="${PATH}:/usr/sbin:/sbin:$HOME/git/go/bin"
export PATH="${PATH}:/opt/gcc-arm-none-eabi-8-2018-q4-major/bin"

export PATH="/home/dongkc/.config/guix/current/bin/${PATH:+:}$PATH"
export PATH="/home/dongkc/.guix-profile/bin${PATH:+:}$PATH"
export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"
export GOPATH="$HOME/git/go"
export INFOPATH="/home/dongkc/.guix-profile/share/info${INFOPATH:+:}$INFOPATH"

export GOROOT="/usr/lib64/go1.11/go"

export http_proxy="http://127.0.0.1:7777"
export https_proxy="http://127.0.0.1:7777"
export TZ='Asia/Shanghai'

export PATH="/home/dongkc/.guix-profile/bin:/home/dongkc/.guix-profile/sbin${PATH:+:}$PATH"
   export CPATH="/home/dongkc/.guix-profile/include${CPATH:+:}$CPATH"
   export LIBRARY_PATH="/home/dongkc/.guix-profile/lib${LIBRARY_PATH:+:}$LIBRARY_PATH"
   export CROSS_C_INCLUDE_PATH="/home/dongkc/.guix-profile/arm-none-eabi/include${CROSS_C_INCLUDE_PATH:+:}$CROSS_C_INCLUDE_PATH"
   export CROSS_CPLUS_INCLUDE_PATH="/home/dongkc/.guix-profile/arm-none-eabi/include${CROSS_CPLUS_INCLUDE_PATH:+:}$CROSS_CPLUS_INCLUDE_PATH"
   export CROSS_LIBRARY_PATH="/home/dongkc/.guix-profile/arm-none-eabi/lib${CROSS_LIBRARY_PATH:+:}$CROSS_LIBRARY_PATH"
   export PASSWORD_STORE_SYSTEM_EXTENSION_DIR="/home/dongkc/.guix-profile/lib/password-store/extensions${PASSWORD_STORE_SYSTEM_EXTENSION_DIR:+:}$PASSWORD_STORE_SYSTEM_EXTENSION_DIR"
   export CMAKE_PREFIX_PATH="/home/dongkc/.guix-profile/${CMAKE_PREFIX_PATH:+:}$CMAKE_PREFIX_PATH"
   export INFOPATH="/home/dongkc/.guix-profile/share/info${INFOPATH:+:}$INFOPATH"


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

