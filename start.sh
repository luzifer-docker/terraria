#!/bin/bash

if ! [ -e /data/config.ini ]; then
  cp ${SERVER}/config.ini.default /data/config.ini
fi

# FIX: The ZIP archive does not have correct permissions
chmod +x /home/gameserver/terraria/Dedicated\ Server/Linux/TerrariaServer*

exec tail -f /dev/null | ${SERVER}/Dedicated\ Server/Linux/TerrariaServer.bin.x86_64 \
  -config /data/config.ini
