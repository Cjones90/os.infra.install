#!/bin/bash

sudo apt-get purge mongodb mongodb-clients mongodb-server mongodb-dev -y
sudo apt-get purge mongodb-10gen -y
sudo apt-get autoremove -y
