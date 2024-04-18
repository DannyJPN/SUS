sudo apt install apache2 libapache2-mod-php default-mysql-server php-mbstring php-xml php-mysql
#a2enmod userdir
#mkdir ~/public_html -p
mkdir /var/www/www.kru0142.org -p
mkdir /var/www/wiki.kru0142.org -p
echo "KRU0142 Page" >> /var/www/www.kru0142.org/index.php
sudo a2enmod ssl
cd /etc/apache2/sites-available/;
cp 000-default.conf www.kru0142.org.conf -v
cp 000-default.conf wiki.kru0142.org.conf -v
sudo a2ensite www.kru0142.org
sudo a2ensite wiki.kru0142.org
sudo a2dissite 000-default
#<?php phpinfo(); ?>
wget https://releases.wikimedia.org/mediawiki/1.34/mediawiki-1.34.1.tar.gz
tar -xavf mediawiki-1.34.1.tar.gz
cp -rv mediawiki-1.34.1.tar.gz/* /var/www/wiki.kru0142.org/