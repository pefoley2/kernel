#!/bin/bash
DIR=/root/kernel/vmkernel
SRC=/usr/src/linux
config() { echo CONFIG_$2=$1 >> .config; }
#rm -rf $DIR
mkdir -p $DIR
cd $DIR
make -C $SRC distclean &>log
make -C $SRC O=$DIR defconfig &>>log
config y KERNEL_XZ
config y IKCONFIG
config y IKCONFIG_PROC
config y DEVTMPFS
config y PARAVIRT_GUEST
config y PARAVIRT_SPINLOCKS
config y VIRTIO_PCI
config y VIRTIO_BALLOON
config y VIRTIO_CONSOLE
config y VIRTIO_NET
config y SCSI_LOWLEVEL
config y VIRTIO_SCSI
config y VIRTIO_BLK
config y DRM_CIRRUS_QEMU
yes "" | make oldconfig &>>log
rm -f .config.old
