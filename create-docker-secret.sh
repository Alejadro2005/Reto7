#!/bin/bash

# Crear el secreto de Docker Hub
kubectl create secret docker-registry docker-credentials \
    --docker-server=https://index.docker.io/v1/ \
    --docker-username=alejandromons \
    --docker-password=Alejo.1027801729 \
    --docker-email=alejandromons@example.com 