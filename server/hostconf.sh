#!/bin/bash
DIR=/root/kernel/hostkernel
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
config y EFI_STUB
config y CMDLINE_BOOL
config y KVM
config y KVM_INTEL
config y VHOST_NET
config y IGB
config y FB_VESA
config y KSM
config m TUN
config m BRIDGE
config m BRIDGE_NF_EBTABLES
config m BRIDGE_EBT_T_NAT
config y NETFILTER_ADVANCED
config m NETFILTER_XT_TARGET_CHECKSUM
config y BLK_CGROUP
config m FUSE_FS
#LXC
config y DEVPTS_MULTIPLE_INSTANCES
config y USER_NS
config y CGROUP_DEVICE
config y MEMCG
config y MACVLAN
config y VETH
config y VLAN_8021Q
config \"root=/dev/sdb3\" CMDLINE
#config \"root=UUID=74527386-880c-42b7-b442-cc37416bdea6\" CMDLINE
yes "" | make oldconfig &>>log
rm -f .config.old
