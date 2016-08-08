# docker-backup-volume
(Work in progress!)

Shell script for backing up a whole docker-volume as a tar and restoring a new docker-volume from an existing tar.

##### Backing up a docker-volume
```
sh backup-docker-volume.sh my_docker_volume /home/myself/backups
```
Creates a file named my_docker_volume-backup-D-M-Y-H.M.S.tar.gz under the path /home/myself/backups. The file will contain the whole content of "my_docker_volume".

The script starts a self-removing docker container that mounts the docker-volume and the local folder, creates a tar in to the local folder and then exits.

Note that the local path must exist and be "writable".

##### Restoring a docker volume
```
sh restore-docker-volume.sh my_restored_docker_volume /home/myself/backups/my_docker_volume_backup.tar.gz
```
Creates a docker-volume called my_restored_docker_volume (must not exist from before), starts a self-removing docker-container that mounts the empty docker-volume and the specified tar, extracts the contents of the tar into the docker-volume and exits.

A new container can then be started and mount the restored volume.

##### Future improvements / usecases
The best usecase for the scripts is to use them together with application-specific backup-scripts (start/stop application, etc) which delegates to the scripts with appropriate volume-names and file-paths.
