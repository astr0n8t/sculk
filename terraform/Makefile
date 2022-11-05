all:
	terraform apply
	./duckdns.sh
clean:
	terraform destroy
	./duckdns.sh 127.0.0.1