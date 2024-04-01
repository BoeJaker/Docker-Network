#!/bin/sh
# Flush existing rules
iptables -F
iptables -t nat -F
iptables -t mangle -F
iptables -X

# Run the firewall in disabled state by default
exec signal_handler.sh

# Keep container running
tail -f /dev/null
