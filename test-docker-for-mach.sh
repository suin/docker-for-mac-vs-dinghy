#!/usr/bin/env bash

set -eux

PATH=/Applications/Docker.app/Contents/Resources/bin:$PATH

open -a Docker

set +x
while true
do
	echo "waiting for that Docker for Mac starts"
	docker ps > /dev/null 2>&1 && break
	sleep 1
done
set -x

docker version

docker run --rm -it -v "$(pwd):/pwd" -w /pwd alpine time dd if=/dev/zero of=speedtest bs=1024 count=100000

docker run --rm -it -v "$(pwd):/pwd:cached" -w /pwd alpine time dd if=/dev/zero of=speedtest bs=1024 count=100000

docker run --rm -it -v "$(PWD):/pwd:delegated" -w /pwd alpine time dd if=/dev/zero of=speedtest bs=1024 count=100000

osascript -e 'quit app "Docker"'
