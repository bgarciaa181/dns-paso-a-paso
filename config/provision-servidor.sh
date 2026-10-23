#!/usr/bin/env bash
apt-get update
apt-get install -y bind9 bind9utils bind9-doc dnsutils
cp /vagrant/files/named /etc/default/named
cp /vagrant/files/named.conf.options /etc/bind/named.conf.options
cp /vagrant/files/named.conf.local /etc/bind/named.conf.local
cp /vagrant/files/bea.test.dns /var/lib/bind/bea.test.dns
cp /vagrant/files/bea.test.rev /var/lib/bind/bea.test.rev
systemctl restart named
