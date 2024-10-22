#!/bin/bash
#Script for the installation of the web UI

HOST="db-host"
apt-get update
apt-get upgrade -y
apt-get install apache2 php=2:8.1+92ubuntu1 php-cgi php-mysqli php-pear php-mbstring libapache2-mod-php php-common mariadb-client php-phpseclib php-mysql -y
#Enables mysqli extension
sed -i 's/;extension=mysqli/extension=mysqli/' /etc/php/8.1/apache2/php.ini
#Enables pdo_mysql extension
sed -i 's/;extension=pdo_mysql/extension=pdo_mysql/' /etc/php/8.1/apache2/php.ini

#replaces old index.html with adminer
rm /var/www/html/index.html
cp /vagrant/scripts/adminer.php /var/www/html/index.php
systemctl restart apache2

#add the db hostname in the file hosts
echo "10.10.20.11   $HOST" >> /etc/hosts
echo "The DB host is reachable at $HOST"