#!/usr/bin/env bash

# dsniff won't install without this, for some reason, and we need it for arpspoof
groupadd ssl-cert

apt-get update
apt-get install -y apache2 imagemagick squid3 dsniff screen

# Before re-adding this include directive, check it doesn't already exist. This allows us to re-provision a vagrant box without duplicating the config
grep -q prank.inc /etc/squid3/squid.conf
if [ $? -eq 1 ]; then
	echo "# Include custom squid directives for pranking" >> /etc/squid3/squid.conf
	echo "include /etc/squid3/prank.inc" >> /etc/squid3/squid.conf
fi

grep -q prank /etc/fstab
if [ $? -eq 1 ]; then
	echo "tmpfs /var/www/prank tmpfs defaults,noexec,nosuid 0 0" >> /etc/fstab
	mkdir /var/www/prank
	mount /var/www/prank
	chown proxy /var/www/prank
	usermod -G proxy www-data
fi

ln -fs /vagrant/prank* /etc/squid3/

# Permit any RFC1918 ranges to access squid (for maximum prank compatibility)
sed -i -e "s|#acl localnet src|acl localnet src|g" /etc/squid3/squid.conf
sed -i -e "s|#http_access allow localnet|http_access allow localnet|g" /etc/squid3/squid.conf

# Permit IP forwarding
sed -i -e "s|#net.ipv4.ip_forward=1|net.ipv4.ip_forward=1|g" /etc/sysctl.conf


service apache2 restart
service squid3 restart
