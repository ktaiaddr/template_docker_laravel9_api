#!/bin/bash
docker exec -it -u `id -u` $(docker ps -a | awk '{if($0 ~ /web_/){ print $NF}}') /bin/bash

