sudo nano /etc/network/interfaces
sudo ifup -a
sudo apt -y  update && sudo apt -y  full-upgrade && sudo apt -y  install isc-dhcp-server
sudo nano /etc/dhcp/dhcpd.conf
sudo nano  /etc/default/isc-dhcp-server
sudo service isc-dhcp-server start
sudo service isc-dhcp-server status
sudo iptables -j MASQUERADE -A POSTROUTING -t nat -o enp0s3
sudo nano /etc/sysctl.conf
sudo apt -y  install iptables-persistent tftpd-hpa wget
sudo cat /etc/default/tftpd-hpa
cd /srv/tftp
sudo wget -v "http://ftp.debian.org/debian/dists/stretch/main/installer-amd64/current/images/netboot/netboot.tar.gz"
sudo tar -xavf netboot.tar.gz
sudo apt -y  install nfs-kernel-server
sudo nano /etc/exports
sudo mkdir /remote/root
sudo service nfs-kernel-server restart
sudo cp -arv /usr/lib* /remote/root
sudo cp -arv /bin /remote/root/bin
sudo cp -arv /boot /remote/root/boot
sudo mkdir /remote/root/dev
sudo cp -arv /etc /remote/root/etc
sudo cp -arv /home
sudo cp -arv /lib /remote/root/lib
sudo cp -arv /lib64 /remote/root/lib64
sudo mkdir /remote/root/media
sudo mkdir /remote/root/mnt
sudo cp -arv /opt /remote/root/opt
sudo mkdir /remote/root/proc
sudo cp -arv /root /remote/root/root
sudo mkdir /remote/root/run
sudo cp -arv /sbin /remote/root/sbin
sudo cp -arv /srv /remote/root/srv
sudo mkdir /remote/root/sys
sudo mkdir /remote/root/tmp
sudo cp -arv /usr /remote/root/usr
sudo cp -arv /var /remote/root/var
cd /srv/tftp
sudo mkdir bckp
sudo cp -arv debian-installer  bckp/debian-installer
sudo cp -arv ldlinux.c32       bckp/ldlinux.c32
sudo cp -arv netboot.tar.gz    bckp/netboot.tar.gz
sudo cp -arv pxelinux.cfg      bckp/pxelinux.cfg
sudo cp -arv pxelinux.0        bckp/pxelinux.0 
sudo cp -arv version.info      bckp/version.info      

sudo mkdir Debian
sudo cp -arv /boot/initrd*4.19* Debian/
sudo cp -arv /boot/vmlinuz*4.19* Debian/ 

sudo nano pxelinux.cfg/default
sudo nano etc/network/interfaces
sudo nano etc/fstab
sudo cp -arv debian-installer/amd64/boot-screens/*32 /srv/tftp/