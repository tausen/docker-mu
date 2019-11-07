#!/bin/bash

docker exec -it -u $UID:$GID mu /bin/bash -c 'emacsclient -c -nw'
