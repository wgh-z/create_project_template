#/bin/bash

# chmod +x run.sh

image_name=alt_server
tag=latest
container_name=alt_server

docker stop ${image_name}:latest
docker rm ${image_name}:latest

docker run --rm -it \
--gpus all \
-v /media/wgh-ubuntu/HDD2/Projects/weights/sam:/home/appuser/weights \
-p : \
--name ${container_name} \
${image_name}:${tag}

# 清除悬挂的容器
docker container prune -f

# 清除悬挂的镜像
docker image prune -f
