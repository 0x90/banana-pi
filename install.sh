#!/bin/sh

echo "Updating system..."
pacman -Syyuu

echo "Installing basic software..."
sudo pacman -S --needed nfs-utils htop openssh autofs alsa-utils alsa-firmware alsa-lib alsa-plugins git zsh wget base-devel diffutils libnewt dialog wpa_supplicant wireless_tools iw crda lshw

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

echo "Installing blackarch.."
 curl -O https://blackarch.org/strap.sh 
chmod +x strap.sh 
sudo ./strap.sh

echo "Install network configs.."
cp 50-br0.netdev /etc/systemd/network/
cp 51-eth0.network /etc/systemd/network/
cp 52-wlan0.network /etc/systemd/network/
cp 60-br0.network /etc/systemd/network/
cp hostapd.conf /etc/hostapd/hostapd.conf
cp swconfig.service /etc/systemd/swconfig.service
cp swconfig.sh /root/swconfig.sh
