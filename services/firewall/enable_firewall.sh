#!/bin/sh

# Enable firewall rules to allow SSH traffic to and from traefik host
iptables -A INPUT -p tcp -s 10.0.0.0/8 --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp -d 10.0.0.0/8 --dport 22 -j ACCEPT

# Log the enable event
echo "Firewall enabled. Allowing SSH traffic to and from traefik host." >> /var/log/firewall.log
