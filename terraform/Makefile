all:
	terraform apply
	./duckdns.sh
setup:
	terraform login
clean:
	terraform destroy
	./duckdns.sh 127.0.0.1