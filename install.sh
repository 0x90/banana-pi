#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "Updating system..."
  sudo pacman -Syyuu

  echo "Installing basic software..."
  sudo pacman -Sy --needed nfs-utils htop openssh autofs alsa-utils alsa-firmware alsa-lib alsa-plugins git zsh wget base-devel yajl diffutils libnewt dialog wpa_supplicant wireless_tools iw crda lshw hostapd

  echo "Installing package-query and yaourt.."
  wget https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz
  tar -xvzf package-query.tar.gz
  cd package-query
  makepkg -si
  cd ..
  wget https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
  tar -xvzf yaourt.tar.gz
  cd yaourt
  makepkg -si
  cd ../
  rm -rf package-query/ package-query.tar.gz yaourt/ yaourt.tar.gz

  echo "Installing blackarch. Don't forget to add http://mirror.yandex.ru/mirrors/blackarch/ to /etc/pacman.conf"
  curl -O https://blackarch.org/strap.sh
  chmod +x strap.sh
  sudo ./strap.sh

  echo "Install network configs.."
  sudo cp 50-br0.netdev /etc/systemd/network/
  sudo cp 51-eth0.network /etc/systemd/network/
  sudo cp 52-wlan0.network /etc/systemd/network/
  sudo cp 60-br0.network /etc/systemd/network/
  sudo cp hostapd.conf /etc/hostapd/hostapd_new.conf
  sudo cp swconfig.service /etc/systemd/swconfig.service
  sudo cp swconfig.sh /root/swconfig.sh
else
  echo "Run as non root user please" 2>&1
  exit 1
fi
