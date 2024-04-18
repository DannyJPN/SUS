sudo apt update
sudo apt install make gcc libncurses-dev bc xz-utils libelf-dev libssl-dev bison flex wget xz-utils
sudo echo "/dev/sdb1 /usr/src ext4 defaults 0 0" >> /etc/fstab;
sudo cfdisk /dev/sdb;
sudo mount -a;
cd /usr/src;
sudo wget -v https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.10.16.tar.xz;
sudo xz -d linux-5.10.16.tar.xz -v;
sudo tar -xavf linux-5.10.16.tar;
sudo ln -s linux-5.10.16 linux;

sudo wget -v http://seidl.cs.vsb.cz/iso/config_4.15.7
sudo nano config_4.15.7;

cd linux;
sudo make menuconfig;
sudo make -j 4;
sudo make -j 4 modules;
sudo make -j 4 modules_install;
sudo make install;


