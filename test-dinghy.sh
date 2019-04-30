#!/usr/bin/env bash

set -eux

dinghy create --provider xhyve --cpus 4 --memory 2048 > dinghy-create-xhyve.log

eval $(dinghy env)

set +x
while true
do
	docker ps > /dev/null && break
	sleep 1
done
set -x

docker version

docker run --rm -it -v "$(pwd):/pwd" -w /pwd alpine time dd if=/dev/zero of=speedtest bs=1024 count=100000

dinghy destroy --force
