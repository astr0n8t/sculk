all:
	ansible-playbook main.yml -i inventory.yml --ask-vault-pass
setup:
	ansible-playbook general_setup.yml -i inventory.yml --ask-vault-pass
wg:
	ansible-playbook deploy_wireguard.yml -i inventory.yml --ask-vault-pass
containers:
	ansible-playbook deploy_containers.yml -i inventory.yml --ask-vault-pass
backups:
	ansible-playbook deploy_backups.yml -i inventory.yml --ask-vault-pass
ssh:
	ansible-playbook harden_ssh.yml -i inventory.yml --ask-vault-pass