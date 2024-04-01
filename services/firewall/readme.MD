A firewall with lockout capabilities.
If the firewall gets a SIGUSR1 signal it will shutdown the gateway, stopping traffic flow between network sections

Usage: docker kill -s SIGUSR1 <container_id>