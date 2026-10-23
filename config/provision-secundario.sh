#!/usr/bin/env bash
apt-get update
apt-get install -y bind9 bind9-utils dnsutils
cp /vagrant/files/named /etc/default/named
cp /vagrant/files/secundario/named.conf.options /etc/bind/named.conf.options
cp /vagrant/files/secundario/named.conf.local /etc/bind/named.conf.local
systemctl restart named
sleep 5
dig @192.168.56.10 bea.test SOA +short
dig @192.168.56.11 bea.test SOA +short
