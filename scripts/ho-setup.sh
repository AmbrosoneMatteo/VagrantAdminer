#!/bin/bash

sudo cp /vagrant/scripts/50-vagrant.yaml /etc/netplan
sudo chmod 0600 /etc/netplan/50-vagrant.yaml
sudo netplan apply
ip a