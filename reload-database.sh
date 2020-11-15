#!/bin/bash
PS_ID=$(docker ps -a | grep "study-track-database" | awk '{print $1}')
if [ ! "$PS_ID" == "" ]; then
    echo "Killing container $PS_ID"
    docker kill study-track-database &>/dev/null
    docker rm study-track-database &>/dev/null
else
    echo "Container study-track-database not found"
fi

IMAGE_ID=$(docker images | grep "study-track-database" | awk '{print $3}')
if [ ! "$IMAGE_ID" == "" ]; then
    echo "Removing old image"
    docker rmi -f $IMAGE_ID
else
    echo "Image not found"
fi

echo "Creating image..."

docker build . --tag lucasgomestech/study-track-database:0.1.0

echo "Creating container..."

docker run -d --name=study-track-database -p 0.0.0.0:5432:5432 lucasgomestech/study-track-database:0.1.0

echo "Waiting for Postgres to start up, sleeping for 10 seconds..."

sleep 10

echo "Done!"
