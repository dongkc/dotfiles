#!/bin/sh

stage_2_prepare() {
eval "cat >/mnt/stage_2.sh << EOF
#!/bin/sh

PKGS_X='
xorg-server
xorg-xinit
xorg-utils
xorg-server-utils
mesa
'

PKGS_SOUND='
alsa-utils
alsa-tools
'

PKGS_VIDEO='
xf86-video-vesa
xf86-video-intel
'

PKGS_TOUCH='
xf86-input-synaptics
'

PKGS_BOOTLOADER='
syslinux
'
PKGS_NETWORK='
networkmanager
net-tools
'

PKGS_FONTS='
ttf-dejavu
ttf-inconsolata
ttf-anonymous-pro
ttf-wqy-microhei-ibx
ttf-wqy-zenhei-ibx
ttf-oxygen-ibx
'

PKGS_SHELL='
zsh
'

PKGS_DISPLAY='
slim
slock
'

PKGS_INPUT='
fcitx
'

PKGS_TOOLS='
cairo-infinality-ultimate
freetype2-infinality-ultimate
fontconfig-infinality-ultimate
base-devel
linux-headers
cmake
wget
xorg-luit
sudo
alsa-tools
ntfs-3g
dos2unix
hexedit
rsync
colord
binutils
autojump
arch-install-scripts
cronie
imagemagick
libnotify
clang
ctags
cscope
hub
pulseaudio
pulseaudio-alsa
'

PKGS_APPS='
rxvt-unicode
mutt
yaourt
ranger
vim
git
openssh
luakit
w3m
zathura
zathura-pdf-poppler
poppler-data
feh
irssi
slrn
mpd
mpc
ncmpcpp
asciidoc
redshift
retawq
newsbeuter
unclutter
'

PKGS_YAOURT='
awesome
vundle-git
vim-colors-solarized-git
keynav-git
urxvt-clipboard
fcitx-sogoupinyin
'

__install() {
  for pkg in \\\$@
  do
    pacman -S --needed --noconfirm \\\$pkg
    if [ $0 != "0" ]
    then
      echo $pkg >> /tmp/failed_pkg
    fi
  done
}

__yaourt_install() {
  for pkg in \\\$@
  do
    sudo -u dongkc yaourt -S --needed --noconfirm \\\$pkg
  done
}

install_pacman_pkg() {
# tools
__install \\\$PKGS_TOOLS

# X server
__install \\\$PKGS_X

# Sound driver
__install \\\$PKGS_SOUND

# Video driver
__install \\\$PKGS_VIDEO

# TouchPad driver
__install \\\$PKGS_TOUCH

# Bootloader
__install \\\$PKGS_BOOTLOADER

# network manager
__install \\\$PKGS_NETWORK

# fonts
__install \\\$PKGS_FONTS

# input mathod
__install \\\$PKGS_INPUT

# shell
__install \\\$PKGS_SHELL

# Display manager
__install \\\$PKGS_DISPLAY

# Application
__install \\\$PKGS_APPS

}

install_yaourt_pkg() {
  __yaourt_install \\\$PKGS_YAOURT
}

#######################################################################

config_user_before() {
  useradd -m dongkc
  chsh -s /bin/zsh dongkc

  echo 'dongkc ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
  echo 'root ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

}

config_user_after() {
  cd /home/dongkc
  sudo -u dongkc git clone --recursive http://github.com/dongkc/dotfiles .dot
  sudo -u dongkc .dot/bin/dfm install

  sudo -u dongkc mkdir -p /home/dongkc/.data/luakit/adblock
  cd /home/dongkc/.data/luakit/adblock
  sudo -u dongkc /home/dongkc/bin/adblock-update.sh

  # fonts config
  rm /etc/fonts/conf.d/83-yes-bitmaps.conf
  cd /etc/fonts/conf.d && ln -s /etc/fonts/conf.avail.infinality/82-no-bitmaps.conf

  mkinitcpio -p linux
}

config_sys_after()
{
  # host name
  echo "dongkc" > /etc/hostname

  # locale gen
  sed -i '/#zh_CN/s/#//g' /etc/locale.gen
  sed -i '/#en_US/s/#//g' /etc/locale.gen
  locale-gen

  # localtime
  ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

  # boot loader setting
  syslinux-install_update -i -a -m

  sed -i 's/sda3/sda1/g' /boot/syslinux/syslinux.cfg

  # service setting
  systemctl enable NetworkManager
  systemctl enable slim
  systemctl enable cronie

}

config_sys_before() {
  echo '[archlinuxfr]' >> /etc/pacman.conf
  echo 'SigLevel = Optional TrustAll' >> /etc/pacman.conf
  echo 'Server = http://repo.archlinux.fr/x86_64' >> /etc/pacman.conf

  echo 'Server = http://mirrors.163.com/archlinux/STAMP/os/x86_64' >> /etc/pacman.d/mirrorlist
  sed -i 's/STAMP/\\\$repo/g' /etc/pacman.d/mirrorlist

  echo 'LANG=en_US.UTF-8' >> /etc/locale.conf
  echo 'LC_COLLATE=C' >> /etc/locale.conf

  pacman -Sy

  sed -i '/^HOOK/s/block //g' /etc/mkinitcpio.conf
  sed -i '/^HOOK/s/udev/udev block/g' /etc/mkinitcpio.conf
}

run() {
  config_sys_before
  install_pacman_pkg
  config_sys_after

  config_user_before
  install_yaourt_pkg
  config_user_after
}
##################################################################

run
EOF"

chmod 755 /mnt/stage_2.sh
}

stage_1_run() {
  pacstrap /mnt base
  genfstab -p /mnt  | grep -v swap >> /mnt/etc/fstab

}

stage_2_run() {
  stage_2_prepare

  arch-chroot /mnt /stage_2.sh
}

cleanup () {
  rm /mnt/stage_2.sh
}

run() {
  stage_1_run
  stage_2_run
  cleanup

  echo "Install done, please set password manually before rebooting !!!"
}
##################################################################

run
