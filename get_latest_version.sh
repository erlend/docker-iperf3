#!/bin/sh

REPO='esnet/iperf'

curl --silent "https://api.github.com/repos/${REPO}/tags" \
  | jq --raw-output '.[].name' \
  | awk '/^[0-9]/ { print; exit }'
