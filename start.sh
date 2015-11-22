#!/bin/bash

if ! [ -e /data/config.ini ]; then
  cp ${SERVER}/config.ini.default /data/config.ini
fi

exec ${SERVER}/server/TerrariaServer.bin.x86_64 \
  -config /data/config.ini
