#!/bin/sh
# Flush existing rules
iptables -F
iptables -t nat -F
iptables -t mangle -F
iptables -X

# Disable all firewall rules except for command signal (e.g., SIGUSR1)
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP
iptables -A INPUT -p signal --signal SIGUSR1 -j ACCEPT
iptables -A OUTPUT -p signal --signal SIGUSR1 -j ACCEPT

# Log the disable event
echo "Firewall disabled. All traffic except command signal blocked." >> /var/log/firewall.log
