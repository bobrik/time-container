# Time Container

Time capsule and apple share in docker.

## Running

```
docker run -d -p <docker_host_ip>:548:548 -v <docker_host_dir>:/share \
  -e AFPD_LOGIN=<login> -e AFPD_PASSWORD=<password> \
  -e AFPD_NAME="<share name>" -e AFPD_SIZE_LIMIT=<size limit in mb if needed> \
  --name <container name> time-container
```

This will bind `afpd` to docker host ip address and mount
directory on docker host to container.

## Connecting

Open Finder, then press ⌘K. Enter `afp://<docker_host_ip>` and
press `Connect`. Enter login and password you supplied at
the build stage.

That's it!

## Time machine

Note that Time Machine will not work on non-standard port, so use 548.

You may need to run the following command to enable Time machine backups:

```
defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes 1  
```
