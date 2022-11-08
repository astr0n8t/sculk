# Setup

Once all of the [requirements](./REQUIREMENTS.md) are setup, the install script can be initialized with once command:
```
make setup
```

This will initiate the setup.sh script in each folder and walk you through setting all of the required variables to deploy sculk.

## Script Walkthrough

The script does a couple of things:

1. Log-in to Azure using `az login`
2. Ask if Terraform Cloud will be used, if it is login via `terraform login`
3. Also, ask for Terraform Cloud workspace and organization if using it.
4. Look for SSH keys in your SSH Agent and ask if you want to use them for setup.
5. Look for SSH keys in your SSH Agent and ask if you want to use them for authentication.
6. Ask for your DuckDNS domain.
7. Ask for your DuckDNS API token.
8. Ask you for your desired username.
9. Ask you for your desired password.
10. Generate WireGuard private/public keypairs.
11. Generate WireGuard client config.
12. Encrypt all sensitive Ansible variables with ansible-vault.

# Next

Next continue to [install](./INSTALL.md)