#!/bin/bash

CONTAINER_NAME="tf2-ugly-hat-remover"


echo "Creating the archive..."
docker compose up -d --build

docker exec "$CONTAINER_NAME" bash -c "mv /tfmod/ugly-hat-remover.vpk /out"
echo "Archive copied outside the container..."

docker compose down
echo "Archive creation complete..."
