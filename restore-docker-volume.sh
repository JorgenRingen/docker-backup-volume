#!/bin/sh

# STEPS:
# 1. Validate that the docker-volume doesn't exist and that the restore file (tar.gz) exists
# 2. Start a new container that mounts the docker-volume and the restore file
# 3. Extract the content of the restore file to the docker-volume
# 4. A new container can now mount the restored docker-volume

DOCKER_RESTORE_VOLUME=$1
RESTORE_FILE=$2
DOCKER_IMAGE=alpine

function validateInput() {
    if [ ! -f "${RESTORE_FILE}" ] ; then
        echo "> Error: Restore file not found at ${RESTORE_FILE}"
        exit 1
    fi

    INSPECT_VOLUME=$(docker volume inspect ${DOCKER_RESTORE_VOLUME} 2>&1)
    if [[ ! ${INSPECT_VOLUME} == *"No such volume"* ]] ; then
        echo "> Error: docker volume '${DOCKER_RESTORE_VOLUME}' already exists"
        exit 1
    fi
}

echo "> Restoring the file '${RESTORE_FILE}' to docker-volume '${DOCKER_RESTORE_VOLUME}'"
validateInput

echo "> Creating docker volume:" $(docker volume create --name ${DOCKER_RESTORE_VOLUME})

docker run --rm	\
    -v ${DOCKER_RESTORE_VOLUME}:/backup-dest \
    -v ${RESTORE_FILE}:/restore-src.tar.gz ${DOCKER_IMAGE} \
    tar -xzvf /restore-src.tar.gz -C /backup-dest

echo "> Finished! Docker volume '${DOCKER_RESTORE_VOLUME}' is ready for use"