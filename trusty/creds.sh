#!/bin/bash

source $HOME/code/secrets/logincreds.sh

CREDS_WRITTEN=$(grep @bitbucket.org < $HOME/.git-credentials)

if [[ -z $CREDS_WRITTEN ]]; then
    echo "https://$BIT_CRED@bitbucket.org" >> $HOME/.git-credentials
fi



HELPER_WRITTEN=$(grep [credential] < $HOME/.gitconfig)

if [[ -z $HELPER_WRITTEN ]]; then
    echo '[credential]
        helper = store' >> ~/.gitconfig
fi
