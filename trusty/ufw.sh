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
