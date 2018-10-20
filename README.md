DO NOT WORK YET

docker run --rm -e DISPLAY=${DISPLAY} -v /tmp/.X11-unix:/tmp/.X11-unix --name toolbox  jetbrains-toolbox
docker run --rm -e DISPLAY=${DISPLAY} -v /tmp/.X11-unix:/tmp/.X11-unix --device /dev/dri --name toolbox -it --entrypoint /bin/bash  jetbrains-toolbox


docker build -t jetbrains-toolbox .
