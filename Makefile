all:
	$(MAKE) -C terraform all
	$(MAKE) -C ansible all
setup:
	./setup.sh
	az login
	$(MAKE) -C terraform setup
	$(MAKE) -C ansible setup
clean:
	$(MAKE) -C terraform clean
