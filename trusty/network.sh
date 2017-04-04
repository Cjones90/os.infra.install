#!/bin/bash

HOST_WRITTEN=$(grep 127.0.1.1 < /etc/hosts)

if [[ -z $HOST_WRITTEN ]]; then
    echo "127.0.1.1 $(cat /etc/hostname)" | sudo tee -a /etc/hosts
fi
