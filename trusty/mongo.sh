#!/bin/bash


sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6

MONGO_REPO=$(grep /mongodb-org/3.4 < /etc/apt/sources.list.d/mongodb-org-3.4.list)

if [[ -z $MONGO_REPO ]]; then
    VER=$(lsb_release -a | grep Release | awk '{print $2'})

    if [[ $VER = '14.04' ]]; then
        echo "deb [ arch=amd64 ] http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
    fi
    if [[ $VER = '16.04' ]]; then
        echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
    fi
fi

sudo apt-get update

sudo apt-get install -y mongodb-org

sudo sed -i 's/bindIp/#bindIp/' /etc/mongod.conf

sudo service mongod start


# TODO: Setup default user/pw

# NOTE: For backups, run awscli with proper credentials and proper backup procedures

# NOTE: If on azure, be sure to add the 27017 endpoint

# NOTE: Add applicable ip address's for mongo servers ie, apps, work ips
# sudo ufw allow from IP_ADDRESS to any port 27017 proto tcp   # Mongo port
