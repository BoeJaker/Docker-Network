#!/bin/bash

# Function to add Docker interfaces to iptables rules
add_docker_interfaces() {
    # Get list of Docker interfaces
    docker_interfaces=$(ip addr show | grep -E '^ *link\/docker' | awk '{print $2}' | cut -d ':' -f 1)

    # Add iptables rules for each Docker interface
    for interface in $docker_interfaces; do
        echo "Adding iptables rules for Docker interface $interface"
        iptables -t nat -A PREROUTING -i $interface -p tcp -j REDIRECT --to-port 8080
        iptables -t nat -A PREROUTING -i $interface -p udp -j REDIRECT --to-port 8080
    done
}

# Function to remove Docker interfaces from iptables rules
remove_docker_interfaces() {
    # Get list of Docker interfaces
    docker_interfaces=$(ip addr show | grep -E '^ *link\/docker' | awk '{print $2}' | cut -d ':' -f 1)

    # Remove iptables rules for each Docker interface
    for interface in $docker_interfaces; do
        echo "Removing iptables rules for Docker interface $interface"
        iptables -t nat -D PREROUTING -i $interface -p tcp -j REDIRECT --to-port 8080
        iptables -t nat -D PREROUTING -i $interface -p udp -j REDIRECT --to-port 8080
    done
}

# Check if user has root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Check command-line argument
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 [add|remove]"
    exit 1
fi

# Process command-line argument
case "$1" in
    add)
        add_docker_interfaces
        ;;
    remove)
        remove_docker_interfaces
        ;;
    *)
        echo "Invalid argument: $1"
        echo "Usage: $0 [add|remove]"
        exit 1
        ;;
esac
