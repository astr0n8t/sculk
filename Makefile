all:
	$(MAKE) -C terraform all
setup:
	az login
	$(MAKE) -C terraform setup
clean:
	$(MAKE) -C terraform clean