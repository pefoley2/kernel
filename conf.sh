#!/bin/bash
DIR=/root/kernel
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
yes "" | make oldconfig &>>log
rm -f .config.old
