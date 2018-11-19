#!/usr/bin/bash

INTERFACE=eno1
BRIDGENAME=br0

echo "#################################################"
echo "# Made for Void Linux, use at your own risks ! :)"
echo "#################################################"
echo ""
echo "You have 10s do Ctrl-C if you mistake"
echo ""

for i in {01..10}
do
    echo "."
    sleep 1
done


# Packages installation
sudo xbps-install -S --yes qemu libvirt dbus

# Services activation
sudo ln -s /etc/sv/libvirtd  /var/service
sudo ln -s /etc/sv/virtlogd  /var/service
sudo ln -s /etc/sv/virtlockd /var/service
sudo ln -s /etc/sv/dbus      /var/service

# Bridge creation
sudo ip link add name $BRIDGENAME type bridge
sudo ip link set $BRIDGENAME up
sudo ip link set $INTERFACE up
sudo ip link set $INTERFACE master $BRIDGENAME

