#!/bin/sh

# todo: we probably need to restore the db in this script

PATH_TO_JIRA_IMAGE=$1
RESTORE_FILE=$2

PATH_TO_COMPOSE_FILE=${PATH_TO_JIRA_IMAGE}/docker-compose.yml
JIRA_VOLUME_NAME=jira_volume


function promptUser() {
    echo "> Warning!!! This will delete the '${JIRA_VOLUME_NAME}' volume and the running JIRA container. "
    echo "> A new volume from backup file '${RESTORE_FILE}' will be created and mounted from a new JIRA container"
    read -p "> Are you sure [y/n]? " -n 1 -r
    echo    # (optional) move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        exit 1
    fi
}

promptUser

echo "> Stopping JIRA container..."
docker-compose -f ${PATH_TO_COMPOSE_FILE} stop
echo "> JIRA was stopped..."

echo "> Removing existing container..."
echo y | docker-compose -f ${PATH_TO_COMPOSE_FILE} rm

echo "> Removing existing volume '${JIRA_VOLUME_NAME}'..."
docker volume rm ${JIRA_VOLUME_NAME}

source ../restore-docker-volume.sh ${JIRA_VOLUME_NAME} ${RESTORE_FILE}

echo "> Starting JIRA container...."
docker-compose -f ${PATH_TO_COMPOSE_FILE} up -d