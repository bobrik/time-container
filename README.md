# Time Container

Time capsule and apple share in docker.

## Building

```
./make.sh share_name login password
```

This will make image `time-container-<share_name>`.

## Running

```
docker run -d -p <docker_host_ip>:548:548 -v <docker_host_dir>:/share time-container-<share_name>
```

This will bind `afpd` to docker host ip address and mount
directory on docker host to container.

## Connecting

Open Finder, then press ⌘K. Enter `afp://<docker_host_ip>` and
press `Connect`. Enter login and password you supplied at
the build stage.

That's it!

## Time machine

You may need to run the following command to enable Time machine backups:

```
defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes 1  
```
