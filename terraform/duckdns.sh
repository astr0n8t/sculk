#!/bin/bash

if [ -z "$1" ]
then
    PUBLIC_IP=$(terraform output public_ip_address | sed 's/"//g')
else
    PUBLIC_IP=$1
fi

ansible-playbook -i localhost ../ansible/setup_duckdns.yml --ask-vault-pass --extra-vars "public_ip_address=$PUBLIC_IP"