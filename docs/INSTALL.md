# Install

Once the [setup](./SETUP.md) script has been run, you can run the following and follow the prompts:
```
make
```

This will run all necessary commands to setup and initialize the sculk project in Azure and configure it with Ansible.

## Script Walkthrough

1. Run `terraform apply` from within the terraform directory.
2. Run the *setup_duckdns.yml* Ansible playbook to set the DuckDNS domain to point to the VM Public IP (Note: you will be prompted for your ansible-vault password.)
3. Run the *main.yml* Ansible playbook to configure the sculk VM. (Note: you will be prompted for your ansible-vault password.)

# Post-Install

Once complete, you will be able to load the *client.conf* WireGuard configuration into your WireGuard client and connect.  Once connected, you can access the vaultwarden instance at https://vaultwarden.\<yourdomain\>.duckdns.org and the Adguard Home instance at https://dns.\<yourdomain\>.duckdns.org.  You can also SSH into the VM at \<yourusername\>@sculk.\<yourdomain\>.duckdns.org.

The WireGuard configuration is configured to use the Adguard Home instance for DNS by default.

The Adguard Home instance has the same password as your VM.

The vaultwarden instance has signups enabled so you can create a new account.  You can also disable this after you have created your account by changing the environment variable in the [docker-compose.yaml](../ansible/templates/docker-compose.yaml) file.

Note: it takes time for the Let's Encrypt certificates to be provisioned so it might take a few moments for the services to become available.