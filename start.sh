#!/bin/bash
set -euxo pipefail

if ! [ -e /data/config.ini ]; then
  cp ${SERVER}/config.ini.default /data/config.ini
fi

SERVER_BINARY=$(find /home/gameserver -name 'TerrariaServer.bin.x86_64')

# FIX: The ZIP archive does not have correct permissions
chmod +x "${SERVER_BINARY}"

exec tail -f /dev/null | "${SERVER_BINARY}" -config /data/config.ini "$@"
