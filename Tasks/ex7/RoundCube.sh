sudo apt install roundcube
cd /etc/apache2/sites-available/
cp -r www.kru0142.org.conf roundcube.kru0142.org.conf
sudo systemctl reload apache2
cd /var/www
cp usr/share/roundcube roundcube.kru0142.org -rv
sudo nano /etc/roundcube/config.inc.php

