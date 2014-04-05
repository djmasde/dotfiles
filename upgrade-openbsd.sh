#!/bin/sh
echo "Upgrading The sets, I already downloaded this"
echo "Copy the bsd kernel...."
cp bsd /bsd.sp
cp bsd.rd /bsd.rd
cp bsd.mp /bsd.mp
echo "Upgrading the xserver set...." 
tar -C / -xzvphf xserv55.tgz
echo "Upgrading the xfonts set....."
tar -C / -xzvphf xfont55.tgz
echo "Upgrading the xshare set....."
tar -C / -xzvphf xshare55.tgz
echo "Upgrading the xbase set...."
tar -C / -xzvphf xbase55.tgz
echo "Upgrading the game set...."
tar -C / -xzvphf game55.tgz
echo "Upgrading the comp set...."
tar -C / -xzvphf comp55.tgz
echo "Upgrading the man set...."
tar -C / -xzvphf man55.tgz
echo "Backup the reboot command... (rebut)"
cp /sbin/reboot /sbin/rebut
echo "Upgrading the core set...."
tar -C / -xzvphf base55.tgz
echo "Ok. remember upgrading the xetcXX.tgz and etcXX.tgz with sysmerge in the last reboot"
echo "the new bsd kernel for single processors systems is bsd.sp, for multi bsd.md"
echo "and cd dev and launch MAKEDEV all"
echo "upgrade the packages and ports..."

