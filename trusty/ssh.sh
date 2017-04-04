#!/bin/bash

if [[ ! -f "$HOME/.ssh/id_rsa" ]]; then
    ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -b 4048 -N ''
fi
# TODO: Auto generate authorized keys from other servers
