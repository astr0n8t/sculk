all:
	ansible-playbook main.yml -i inventory.yml --ask-vault-pass
setup:
	./setup.sh
general:
	ansible-playbook general_setup.yml -i inventory.yml --ask-vault-pass
wg:
	ansible-playbook deploy_wireguard.yml -i inventory.yml --ask-vault-pass
containers:
	ansible-playbook deploy_containers.yml -i inventory.yml --ask-vault-pass
ssh:
	ansible-playbook harden_ssh.yml -i inventory.yml --ask-vault-pass
