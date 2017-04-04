#!/bin/bash

PG_APT=$(grep trusty-pgdg < /etc/apt/sources.list.d/pgdg.list)

if [[ -z $PG_APT ]]; then
    echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" | sudo tee -a /etc/apt/sources.list.d/pgdg.list
fi

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  sudo apt-key add -

sudo apt-get update

sudo apt-get install -y postgresql-9.4

# Change postgres 'peer' to 'trust' in pg_hba.conf
sudo sed -i 's/postgres\([[:space:]]\{5,\}\)peer/postgres\1trust/' /etc/postgresql/9.4/main/pg_hba.conf

# Listen on all networks
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /etc/postgresql/9.4/main/postgresql.conf

# Allow connections
#   For now, we are allowing anyone that has access to the server, access to all the databases
#   At a later time we can start allowing specific users/roles/ips, but right now
#   to simplify, we are using UFW to allow specific IPs in

ALREADY_ALLOWED=$(sudo cat /etc/postgresql/9.4/main/pg_hba.conf | grep 0.0.0.0)

if [[ -z $ALREADY_ALLOWED ]]; then
    echo "host    all             all             0.0.0.0/0            trust" | sudo tee -a /etc/postgresql/9.4/main/pg_hba.conf
fi

sudo /etc/init.d/postgresql restart

# sudo -u postgres psql postgres
# \q
# \password postgres

# NOTE: For backups, run awscli with proper credentials and proper backup procedures

# TODO: Setup default user/pw
