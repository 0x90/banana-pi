#!/usr/bin/bash

# exit 0
echo "Configuring Network Switch ..."
ifconfig eth0 up
swconfig dev eth0 set reset 1
swconfig dev eth0 set enable_vlan 1
swconfig dev eth0 vlan 101 set ports '3 8t'
swconfig dev eth0 vlan 102 set ports '4 0 1 2 8t'
swconfig dev eth0 set apply 1
#swconfig dev eth0 show 
sleep 1
echo "Network Switch swconfig done"
echo "adding vlans ..."
ip link add link eth0 name ethint type vlan id 102
sleep 1
ip link add link eth0 name ethext type vlan id 101
sleep 1
echo "add vlans done"
echo "Starting dhcpcd on ethext"
dhcpcd -4 ethext
sleep 3
exit 0
