all:
	terraform apply -var-file="variables.tfvars"
	./duckdns.sh
setup:
	./setup.sh
	terraform init
clean:
	terraform destroy -var-file="variables.tfvars"
	./duckdns.sh 127.0.0.1
