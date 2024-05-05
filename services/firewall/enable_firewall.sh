# Flush existing rules
iptables -F

# Allow traffic from twingate_a and twingate_b to traefik on ports 80 and 443
iptables -A INPUT -s twingate_a -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -s twingate_a -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -s twingate_b -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -s twingate_b -p tcp --dport 443 -j ACCEPT

# Allow traffic to traefik on ports 80 and 443
iptables -A INPUT -p tcp -m multiport --dports 80,443 -j ACCEPT

# Allow established connections and traffic related to these connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Drop all other incoming traffic
iptables -P INPUT DROP

# Keep the container running to maintain the firewall rules
tail -f /dev/null