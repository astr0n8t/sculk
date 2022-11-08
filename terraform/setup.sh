#!/bin/bash

read -p "Would you like to use Terraform Cloud to store your state remotely (y/n):" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "***********************************************************************************************"
    echo
    echo "Please login to Terraform Cloud"
    echo
    echo "***********************************************************************************************"

    terraform login

    read -p "Please enter your Terraform Cloud organization: "
    ORGANIZATION=$REPLY
    read -p "Please enter your Terraform Cloud workspace name: "
    WORKSPACE=$REPLY

    echo "terraform {
    cloud {
        organization = \"$ORGANIZATION\"

        workspaces {
            name = \"$WORKSPACE\"
        }
    }
        required_providers {
            azurerm = {
                source  = \"hashicorp/azurerm\"
                version = \"3.30.0\"
        }
    } 
}
" > backend.tf
else
    echo "terraform {
    required_providers {
        azurerm = {
            source  = \"hashicorp/azurerm\"
            version = \"3.30.0\"
        }
    } 
}
" > backend.tf
fi


