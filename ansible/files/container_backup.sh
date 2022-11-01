#!/bin/bash

PATH=/sbin:/bin:/usr/sbin:/usr/bin

docker run --rm \
	   --volumes-from vaultwarden:ro \
		-e RESTIC_REPOSITORY="" \
		-e RESTIC_PASSWORD="" \
	   --name restic_backup \
       --hostname sculk \
	   docker.io/restic/restic \
	   backup /data --tag vaultwarden
