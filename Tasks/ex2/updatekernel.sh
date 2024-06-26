cd /usr/src;
sudo wget -v https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.10.16.tar.xz;
sudo xz -d linux-5.10.16.tar.xz -v;
sudo tar -xavf linux-5.10.16.tar;
sudo ln -s linux-5.10.16 linux;
cd linux;
sudo make menuconfig;
sudo make -j 4;
sudo make -j 4 modules;
sudo make -j 4 modules_install;
sudo make install;
