#!/bin/bash

docker run -t -d -v /tmp/.X11-unix:/tmp/.X11-unix:ro -v /etc/passwd:/etc/passwd:ro -u $UID:$GID -v $HOME:$HOME -v /tmp/:/tmp/ -e DISPLAY --rm --name mu mu
