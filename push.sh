#!/bin/bash

source config.env

docker push "$DOCKER_HUB_USER"/"$IMAGE_NAME":"$IMAGE_VERSION"
