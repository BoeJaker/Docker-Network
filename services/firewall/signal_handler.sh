#!/bin/sh

# Trap the specified signal (SIGUSR1)
trap 'handle_signal' SIGUSR1

# Function to handle the signal
handle_signal() {
    echo "Received signal to toggle firewall."
    
    # Check the current firewall state
    if [ -f /tmp/firewall_enabled ]; then
        # Firewall is enabled, disable it
        disable_firewall.sh
        rm /tmp/firewall_enabled
    else
        # Firewall is disabled, enable it
        enable_firewall.sh
        touch /tmp/firewall_enabled
    fi
}

# Start the firewall
start_firewall.sh

# tail -f /dev/null 
