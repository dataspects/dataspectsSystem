#!/bin/bash

# https://www.oracle.com/technical-resources/articles/it-infrastructure/admin-manage-vbox-cli.html

# VBoxManage list vms
# VBoxManage list -l runningvms
# VBoxManage list ostypes

VMNAME=dataspectsServer200706
HOSTPATH=/home/lex/dsServerHome # Create this first!

VMDISK=/home/lex/VirtualBoxDrives/$VMNAME.vdi
DISKSIZE=1048576
ISO=/home/lex/Downloads/ubuntu-20.04-live-server-amd64.iso
NETWORKINTERFACE=enp0s31f6

VBoxManage createvm --name $VMNAME --ostype Ubuntu_64 --register
VBoxManage modifyvm $VMNAME --cpus 4 --memory 4096 --vram 12
# Check 'ip addr' on host
VBoxManage modifyvm $VMNAME --nic1 nat --bridgeadapter1 $NETWORKINTERFACE
VBoxManage modifyvm $VMNAME --natpf1 "ssh,tcp,,2222,,22"
VBoxManage modifyvm $VMNAME --natpf1 "mediawiki,tcp,,8080,,80"
VBoxManage modifyvm $VMNAME --natpf1 "search,tcp,,8081,,81"
VBoxManage modifyvm $VMNAME --natpf1 "api,tcp,,17465,,3001"
VBoxManage modifyvm $VMNAME --natpf1 "kibana,tcp,,20065,,5601"
VBoxManage createhd --filename $VMDISK --size $DISKSIZE --variant Standard
VBoxManage storagectl $VMNAME --name "SATA Controller" --add sata --bootable on
VBoxManage storageattach $VMNAME --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $VMDISK

VBoxManage storagectl $VMNAME --name "IDE Controller" --add ide
VBoxManage storageattach $VMNAME --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium $ISO

# VBoxManage sharedfolder add $VMNAME --name "dsServerHome" --hostpath $HOSTPATH

VBoxManage startvm $VMNAME