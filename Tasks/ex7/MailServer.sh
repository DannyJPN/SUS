sudo apt install dnsutils resolvconf net-tools postfix telnet dovecot-imapd
sudo useradd kru0142 -s /bin/bash -G sudo -m
sudo passwd kru0142

sudo login kru0142
sudo echo nameserver 192.168.56.106 >>/etc/resolvconf/resolv.conf.d/head
sudo echo nameserver 192.168.56.104 >>/etc/resolvconf/resolv.conf.d/head
resolvconf -u
sudo nano /etc/postfix/main.cf


postfix reload

telnet localhost 25
helo world
mail from: kru0142@kru0142.org
rcpt to: dan@kru0142.org
data
hello domu
.
quit

telnet localhost 25
helo world
mail from: kru0142@kru0142.org
rcpt to: kru0142@vsb.cz
data
hello domu
.
quit




echo "postmaster: root" >> /etc/aliases
echo "dan: kru0142" >> /etc/aliases
newaliases
echo "dan kru0142">>/etc/postfix/canonical
cd /etc/postfix/
sudo postmap canonical
echo "canonical_maps = hash:/etc/postfix/canonical" >> /etc/postfix/main.cf
echo "home_mailbox = Maildir/" >> /etc/postfix/main.cf
postfix reload


sudo nano /etc/dovecot/conf.d/10-auth.conf 
sudo nano /etc/dovecot/conf.d/10-mail.conf
#mail_location = maildir:~/Maildir/	


#_imap._tcp        IN  SRV   1 2 143  imap.kru0142.org
#_smtp._tcp        IN  SRV   1 2 25  smtp.kru0142.org
