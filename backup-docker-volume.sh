#!/bin/sh

# Work in progress....

# todo: use named parameters, error handling, etc... (too lazy..)
VOLUME_TO_BACKUP=$1
LOCAL_BACKUP_DEST=$2 # must exist on host and have correct read/write
NAME_OF_BACKUP_TAR=$VOLUME_TO_BACKUP-backup-$(date +%d-%m-%y-%H:%M:%S).tar

echo "Backing up the docker-data-volume '$VOLUME_TO_BACKUP' to directory '$LOCAL_BACKUP_DEST'"

# run a container that mounts the VOLUME_TO_BACKUP and the BACKUP_DEST
# the container will create a tar and put it in the BACKUP_DEST
docker run --rm	-v $VOLUME_TO_BACKUP:/backup -v $LOCAL_BACKUP_DEST:/backup-dest ubuntu tar czfP /backup-dest/$NAME_OF_BACKUP_TAR /backup


# todo: whatever post-handling of the tar that might be necessary (listing content for now...)
#echo "Content of backup in $LOCAL_BACKUP_DEST/$NAME_OF_BACKUP_TAR"
echo "Content of backup in $LOCAL_BACKUP_DEST/$NAME_OF_BACKUP_TAR"
tar -tvf $LOCAL_BACKUP_DEST/$NAME_OF_BACKUP_TAR