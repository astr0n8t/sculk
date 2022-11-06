all:
	terraform apply
	./duckdns.sh
setup:
	./setup.sh
	terraform login
clean:
	terraform destroy
	./duckdns.sh 127.0.0.1
