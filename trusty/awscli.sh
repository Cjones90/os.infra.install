#!/bin/bash

# NOTE: Be sure to add aws credentials to server as well by modifiying the
# commented out lines

sudo apt-get install -y python3.4
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user

# Check to see if we've already added the key
AWS_AVAILABLE=$(grep AWS_ACCESS < ~/.bash_profile)
AWS_KEY_ID=$(grep AWS_ACCESS_KEY_ID < $HOME/code/secrets/tokens.sh)
AWS_SECRET_KEY=$(grep AWS_SECRET_ACCESS_KEY < $HOME/code/secrets/tokens.sh)

if [[ -z $AWS_AVAILABLE ]]; then
    echo 'export PATH=~/.local/bin:$PATH' >> ~/.bash_profile
    echo $AWS_KEY_ID >> ~/.bash_profile
    echo $AWS_SECRET_KEY >> ~/.bash_profile
fi

~/.local/bin/pip install awscli --upgrade --user

rm get-pip.py
