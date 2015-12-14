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
'

PKGS_FONTS='
wqy-microhei
wqy-zenhei
wqy-bitmapfont
ttf-dejavu
ttf-inconsolata
ttf-ubuntu-font-family
'

PKGS_SHELL='
zsh
'

PKGS_DISPLAY='
slim
slock
'

PKGS_INPUT='
fcitx-sogoupinyin
fcitx
'

PKGS_TOOLS='
base-devel
sudo
alsa-tools
dos2unix
hexedit
rsync
colord
binutils
arch-install-scripts
'

PKGS_APPS='
rxvt-unicode
mutt
yaourt
ranger
vim
git
luakit
zathura
zathura-pdf-poppler
poppler-data
feh
mplayer
mpcpp
irssi
slrn
ncmpcpp
'

PKGS_YAOURT='
awesome
vundle-git
vim-colors-solarized-git
dircolors-solarized-git
'

__install() {
  for pkg in \\\$@
  do
    pacman -S --needed --noconfirm \\\$pkg
  done
}

__yaourt_install() {
  for pkg in \\\$@
  do
    sudo -u dongkc yaourt -S --needed --noconfirm \\\$pkg
  done
}

install_pacman_pkg() {
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
syslinux-install_update -i -a -m
 
# network manager
__install \\\$PKGS_NETWORK
 systemctl enable NetworkManager
 
# fonts
__install \\\$PKGS_FONTS
 
# shell
__install \\\$PKGS_SHELL
useradd -m dongkc
chsh -s /bin/zsh dongkc
 
# Display manager
__install \\\$PKGS_DISPLAY
systemctl enable slim
 
# Application
__install \\\$PKGS_APPS

# tools
__install \\\$PKGS_TOOLS

}

install_yaourt_pkg() {
  __yaourt_install \\\$PKGS_YAOURT
}

#######################################################################

config_user_before() {
  echo 'dongkc ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
  echo 'root ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
}

config_user_after() {
  cd /home/dongkc
  sudo -u dongkc git clone http://github.com/dongkc/dotfiles .dot
  sudo -u dongkc .dot/bin/dfm install

  mkinitcpio -p linux
}

config_sys_after()
{
  echo "dongkc" > /etc/hostname
}

config_sys_before() {
  echo '[archlinuxfr]' >> /etc/pacman.conf
  echo 'SigLevel = Never' >> /etc/pacman.conf
  echo 'Server = http://repo.archlinux.fr/i686' >> /etc/pacman.conf

  echo 'Server = http://mirrors.163.com/archlinux/STAMP/os/i686' >> /etc/pacman.d/mirrorlist
  sed -i 's/STAMP/$repo/g' /etc/pacman.d/mirrorlist

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
  genfstab -U -p /mnt >> /mnt/etc/fstab
}

stage_2_run() {
  stage_2_prepare

  arch-chroot /mnt /stage_2.sh
}

run() {
  stage_1_run
  stage_2_run
}
##################################################################

run