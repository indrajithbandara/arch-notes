#!/bin/sh

# Install default set of packages
sudo pacman -S firefox xdotool ghostscript wicd mupdf git vim terminus-font kodi pulseaudio pkg-config yajl xorg xorg-xinit emacs make gcc htop sshfs w3m screen dwm patch wget tar base --noconfirm

# Package-query install
wget https://mir.archlinux.fr/releases/package-query/package-query-1.9.tar.gz
tar -xzf package-query-1.9.tar.gz
cd package-query-1.9
./configure
make
sudo make install

# Yaourt install
wget https://github.com/archlinuxfr/yaourt/releases/download/1.9/yaourt-1.9.tar.gz
tar -xzf yaourt-1.9.tar.gz
cd yaourt-1.9
sudo make install
sudo pacman -Syu
sudo touch /usr/local/etc/pacman.conf

# Ssh setup
mkdir .ssh
touch .ssh/config
scp ryan@192.168.1.82:/home/ryan/.ssh/config /home/ryan/.ssh/config

# Emacs setup
git clone https://github.com/watkinsr/emacs.d.git
sudo mv emacs.d .emacs.d

# Correct st and startx script
mkdir /home/ryan/st
scp -r ryan@192.168.1.74:/home/ryan/st/* /home/ryan/st/.
cd /home/ryan/st; sudo make clean install;
scp pi:/home/ryan/.xinitrc .

# Get helper scripts
mkdir scripts && scp pi:/usr/local/bin/* scripts/. && sudo mv scripts/* /usr/local/bin/. && rm -rf scripts

# enable ssh
sudo systemctl enable shhd; sudo systemctl start sshd;

# enable wicd
sudo systemctl enable wicd; sudo systemctl start wicd;
yaourt -S wicd-gtk --noconfirm

# enable NFS attached storage
mnt_lap
