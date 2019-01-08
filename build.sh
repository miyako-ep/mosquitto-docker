#!/usr/bin/env sh

containerName=mymosquitto
containerTag=latest
containerLabel="$containerName:$containerTag"

if [ "_$1" = "_clean" ]; then
    docker stop $containerName
    docker rm -v $containerName
    exit 0
fi
if [ "_$1" = "_cleani" ]; then
    docker stop $containerName
    docker rm -v $containerName
    docker rmi "$containerLabel"
    exit 0
fi

#mkdir -p mosquitto/data mosquitto/log 2>/dev/null
#[ -e mosquitto/log/*.log ] || touch mosquitto/log/mosquitto.log

# docker build -t $containerLabel .

docker run -itd \
    --name=$containerName \
    -v $(pwd)/mosquitto.conf:/mosquitto/config/mosquitto.conf \
    -p 1883:1883 \
    -p 9001:9001 \
    --restart=always \
    eclipse-mosquitto

    #-v $(pwd)/mosquitto/data:/mosquitto/data \
    #-v $(pwd)/mosquitto/log:/mosquitto/log \
