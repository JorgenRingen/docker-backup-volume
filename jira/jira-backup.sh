#!/bin/sh

# todo: we need to probably need to backup the db in this script

PATH_TO_JIRA_IMAGE=$1
PATH_TO_BACKUP_DEST=$2

PATH_TO_COMPOSE_FILE=${PATH_TO_JIRA_IMAGE}/docker-compose.yml
JIRA_VOLUME_NAME=jira_volume

echo "> Stopping JIRA container..."
docker-compose -f ${PATH_TO_COMPOSE_FILE} stop
echo "> JIRA was stopped..."

source ../backup-docker-volume.sh ${JIRA_VOLUME_NAME} ${PATH_TO_BACKUP_DEST}

echo "> Starting JIRA container...."
docker-compose -f ${PATH_TO_COMPOSE_FILE} up -d

