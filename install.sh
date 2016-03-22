#!/bin/sh

cp 50-br0.netdev /etc/systemd/network/
cp 51-eth0.network /etc/systemd/network/
cp 52-wlan0.network /etc/systemd/network/
cp 60-br0.network /etc/systemd/network/
cp hostapd.conf /etc/hostapd/hostapd.conf
cp swconfig.service /etc/systemd/swconfig.service
cp swconfig.sh /root/swconfig.sh
