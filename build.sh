#!/bin/bash

# Argumentos
IMAGE_NAME=$1
TAG=$2

# Construir la imagen con Kaniko
/kaniko/executor \
    --context $(pwd) \
    --dockerfile Dockerfile \
    --destination ${IMAGE_NAME}:${TAG} \
    --cache=true
