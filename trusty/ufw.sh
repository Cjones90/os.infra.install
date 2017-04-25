#!/bin/bash

PORT=""
ALLOW_DB_CON=""
ALLOW_ALL_CON=""

if [[ $1 = "pg" ]]; then PG=true; fi
if [[ $1 = "mongo" ]]; then MONGO=true; fi

# TODO: Make file accessible to REE/HW Dev team
source $HOME/code/secrets/whitelist-ips.sh

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow to any port ssh                          # SSH

# If its an app server
if [[ ! $PG = true ]] && [[ ! $MONGO = true ]]; then
    sudo ufw allow to any port http                     # Http
    sudo ufw allow to any port https                    # SSL
    sudo ufw allow to any port 2377 proto tcp           # Docker
    sudo ufw allow to any port 7946 proto tcp           # Docker
    sudo ufw allow to any port 7946 proto udp           # Docker

    # https://www.arin.net/knowledge/address_filters.html
    # According to standards set forth in Internet Engineering Task Force (IETF)
    # document RFC-1918, the following IPv4 address ranges have been reserved by the
    # IANA for private internets, and are not publicly routable on the global internet:
    #   10.0.0.0/8 IP addresses: 10.0.0.0 -- 10.255.255.255
    #   172.16.0.0/12 IP addresses: 172.16.0.0 -- 172.31.255.255
    #   192.168.0.0/16 IP addresses: 192.168.0.0 – 192.168.255.255

    # https://github.com/moby/moby/pull/29376
    # When doing `docker-compose up`, below are dockers hardcoded subnet pools it
    # pulls from (for now)
    sudo ufw allow from 172.16.0.0/12                   # Docker-compose subnets
    sudo ufw allow from 192.168.0.0/20                  # Docker-compose subnets
fi

# Allow ips based on server role
for ip in "${ALLOW_ALL_CON[@]}"; do
    sudo ufw allow from $ip
done

if [[ ! -z $PORT ]]; then
    for ip in "${ALLOW_DB_CON[@]}"; do
        sudo ufw allow from $ip to any port $PORT proto tcp
    done
fi

sudo ufw --force enable
exit;



# sudo ufw allow to any port 8140 proto tcp           # Puppet port
# sudo ufw allow to any port 9418 proto tcp           # Reserved for Puppet ports
# sudo ufw allow to any port 9418 proto tcp           # Reserved for Puppet ports


# Dont run on production servers
# Wrap in some "If env = prod" block
exit
sudo ufw allow to any port 1194 proto udp           # OpenVPN
sudo ufw allow to any port 3478 proto udp           # OpenVPN
sudo ufw allow from 10.8.0.0/24 to any port         # Allow all VPN connections
sudo ufw allow to any port 9418 proto tcp           # Git daemon/protocol
