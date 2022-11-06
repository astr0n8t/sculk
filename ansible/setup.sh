#!/bin/bash

echo "***********************************************************************************************"
echo
echo "Setting up SSH Key for initial setup"
echo "Azure Terraform requires an SSH Key of type RSA with at least 2048 bits"
echo "This script will check your SSH Agent for a valid key or prompt you to generate a new one"
echo
echo "***********************************************************************************************"

RSA_KEYS=""
i=1
shopt -s lastpipe
ssh-add -L | while IFS= read -r line 
do 
    SSH_KEY_TYPE=$(echo $line | awk '{print $1}')
    if [[ $SSH_KEY_TYPE = *"ssh-rsa"* ]]
    then
        RSA_KEYS="$RSA_KEYS
$i $line"
        ((i=i+1))
    fi
done

if [[ -z $RSA_KEYS ]]
then
    read -p "No SSH Keys of type RSA found.  Would you like to generate a temporary one for setup?" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        ssh-keygen -t rsa -b 4096 -f ../id_rsa
        ssh-add ../id_rsa
    else
        read -p "Please enter a valid SSH public key of type RSA with at least 2048 bits." -n 1 -r
        echo
        echo $REPLY > ../id_rsa.pub  
    fi
else
    echo "Found the following SSH Keys of type RSA:"
    echo "$RSA_KEYS"
    echo
    read -p "Enter the number of which key to use: " -n 1 -r
    echo
    sed -n $(($REPLY+1))p <<< "$RSA_KEYS" | cut -f 2- -d ' ' > ../id_rsa.pub
fi

echo "***********************************************************************************************"
echo
echo "Setting up SSH Keys for authorized_keys file"
echo "These SSH keys will be the only keys in the authorized keys after initial setup"
echo "This script will check your SSH Agent for keys and prompt you to enter additional keys"
echo
echo "***********************************************************************************************"

SSH_KEYS=""
i=1
shopt -s lastpipe
ssh-add -L | while IFS= read -r line 
do 
    SSH_KEYS="$SSH_KEYS
$i $line"
    ((i=i+1))
done

if [[ ! -z $SSH_KEYS ]]
then
    echo "Found the following SSH keys loaded in the SSH agent:"
    echo "$SSH_KEYS"
    read -p "Enter the number of which key to use: " -n 1 -r
    echo
    sed -n $(($REPLY+1))p <<< "$SSH_KEYS" | cut -f 2- -d ' ' > files/authorized_keys
fi

read -p "Would you like to enter any additional keys?" -n 1 -r
echo
until [[ ! $REPLY =~ ^[Yy]$ ]]
do
    read -p "Please enter the extra keys (one per line):" 
    if [[ ! -z $REPLY ]]
    then
        echo $REPLY >> files/authorized_keys
    fi
    read -p "Would you like to enter any additional keys?" -n 1 -r
    echo
done

echo "***********************************************************************************************"
echo
echo "Setting up Variables"
echo "These variables are necessary for setup of your instance"
echo
echo "***********************************************************************************************"

touch vault_vars.yml

read -p "Please enter your DuckDNS domain (i.e. astr0n8t.duckdns.org): "
echo "duckdns_domain: $REPLY" >> vault_vars.yml
DUCKDNS_DOMAIN=$REPLY
read -s -p "Please enter your DuckDNS API token (input is hidden): "
echo
echo "duckdns_token: $REPLY" >> vault_vars.yml
read -p "Please enter your username for Sculk: "
echo "sculk_username: $REPLY" >> vault_vars.yml
read -s -p "Please enter your password for Sculk: "
echo
USER_HASH=$(mkpasswd --method=sha-512 $REPLY)
echo "sculk_user_password_hash: \"$USER_HASH\"" >> vault_vars.yml
ADGUARD_HASH=$(htpasswd -nbB user $REPLY | awk -F':' '{print $2}')
echo "adguard_home_password: \"$ADGUARD_HASH\"" >> vault_vars.yml


echo "***********************************************************************************************"
echo
echo "Generating WireGuard public/private keypairs"
echo
echo "***********************************************************************************************"

PRIVATE_KEY1=$(wg genkey)
PUBLIC_KEY1=$(echo $PRIVATE_KEY1 | wg pubkey)
PRIVATE_KEY2=$(wg genkey)
PUBLIC_KEY2=$(echo $PRIVATE_KEY2 | wg pubkey)

echo "wireguard_private_key: \"$PRIVATE_KEY1\"" >> vault_vars.yml
echo "wireguard_peer1_public_key: \"$PUBLIC_KEY2\"" >> vault_vars.yml

echo "***********************************************************************************************"
echo
echo "Generating WireGuard Client 1 config"
echo "This contains your private key, protect it as you would a password"
echo
echo "***********************************************************************************************"

echo "[Interface]
PrivateKey = $PRIVATE_KEY2
Address = 192.168.71.2/32
DNS = 192.168.71.1

[Peer]
PublicKey = $PUBLIC_KEY1
AllowedIPs = 192.168.71.1/32
Endpoint = vpn.$DUCKDNS_DOMAIN:51820
" > ../client.conf

echo "***********************************************************************************************"
echo
echo "Encrypting your variables with Ansible Vault."
echo "Please enter your new encryption password."
echo
echo "***********************************************************************************************"

ansible-vault encrypt vault_vars.yml