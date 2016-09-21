#!/bin/sh

git clone git://git.yoctoproject.org/poky -b krogoth

cd poky

git clone git://git.openembedded.org/meta-openembedded -b krogoth

git clone git://github.com/meta-qt5/meta-qt5.git -b krogoth

git clone git://github.com/linux4sam/meta-atmel.git -b krogoth
