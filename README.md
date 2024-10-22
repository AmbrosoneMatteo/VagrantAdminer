# VagrantAdminer
## Host-Only interface

This code is developed to be used in a Windows environment with Oracle Virtualbox, 
if you want to use this script in a windows environment remember to cange the Host-Only adapter

```ruby
 web.vm.network "private_network",ip: "#{BASE_NETWORK}.100", name: "VirtualBox Ethernet Adapter", auto_config: false
```

For linux you would have to set something like this:

```ruby
 web.vm.network "private_network",ip: "#{BASE_NETWORK}.100", name: "VirtualBox Ethernet Adapter", auto_config: false
```

### Base Network

The variable 'BASE_NETWORK' defines the network where you will reach your web-host on the
Host-Only interface at the address .100, to change the network you just need to change it's variable

## Intnet

The 2 virtual machines are connected through an internal network with the address 10.10.20.0/24
## Scripts
### web-install.sh

web-install.sh installs all the packages necessary to operate an apache webserver with php 8.1 in order to run adminer.php.
It uses sed to enable the mysql extensions in php.ini, to avoid copying an entire configuration file.
And it adds the db-host entry in the hosts file to be able to reach-it from the web-host through the hostname

### db-install.sh

db-install.sh install mariadb on the db-host and create an user with ALL the privileges on the database test, the password is generated with openssl and is a random 32 character base64 sequence, if you don't want it you can alway change the variable PASS, for example
```sh
    PASS="M1ck3yM0us3"
```

## SSH

SSH key authentication has been disabled due to a problem, if you want to enable it remove this line from the VagrantFile
```ruby
    config.ssh.insert_key = false 
```

### Ports

By default vagrant forwards the ssh port on :2222, but with 2 machines it would create a conflict between these 2, so the db port has been forwarded on :2223