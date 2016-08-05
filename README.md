# docker-backup-volume
Work in progress!

Simple shell script for backing up a docker volume.

Starts a container which mounts the docker volume and a folder on the host. The container tar's the content of the volume and places the tar in the folder on the host.

Usage: sh docker_backup_volume.sh volume-name local-backup-path
