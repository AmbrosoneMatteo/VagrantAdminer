#!/bin/bash
#Script for the installation of the DBMS

PASS=$(openssl rand -base64 32) #generate MYSQL user's password
apt-get update
apt-get upgrade -y 
apt-get install mariadb-client mariadb-server -y
mariadb -e "CREATE USER 'user'@'10.10.20.10' IDENTIFIED BY '$PASS';" #Create the user with the generated password
mariadb -e "CREATE DATABASE test;"
mariadb -e "GRANT ALL ON test.* TO 'user'@'10.10.20.10';"

#change the bind address to work on the intnet interface
sudo sed -i 's/bind-address\s\+= 127.0.0.1/bind-address = 10.10.20.11/' /etc/mysql/mariadb.conf.d/50-server.cnf
systemctl restart mariadb

PASSCOL="\033[0;41m" #black, red background
USERCOL="\033[0;42m" #black, green background
NC="\033[0;0m" #reset colors
echo -e "Access the database at $USERCOL'192.168.56.110'$NC with the user $USERCOL'user'$NC"
echo $PASS > /vagrant/pass
echo -e "Here's your database password, don't loose it, it has been saved at /vagrant/pass ==> ${PASSCOL}$PASS${NC}"