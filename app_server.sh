#!/bin/bash

DIR="$(dirname $0)"

if [[ ! -d "$HOME/code/secrets" ]]; then
    echo "Clone the 'secrets' repo for credentials.";
    exit;
fi

$DIR/trusty/network.sh
$DIR/trusty/essentials.sh
$DIR/trusty/ssh.sh
$DIR/trusty/ufw.sh
$DIR/trusty/creds.sh
# $DIR/trusty/awscli.sh   # We may want aws at some point for file uploads
$DIR/trusty/docker.sh


echo "================ IMPORTANT================
Be sure to remove the UFW rule to allow all
ssh connections once you've confirmed your
IP is whitelisted using 'sudo ufw status'
===================== IMPORTANT================="
