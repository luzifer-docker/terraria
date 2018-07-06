#!/usr/local/bin/dumb-init /bin/bash
set -euxo pipefail

if ! [ -e /data/config.ini ]; then
	cp ${SERVER}/config.ini.default /data/config.ini
fi

SERVER_BINARY=$(find /home/gameserver -name 'TerrariaServer.bin.x86_64')

# FIX: The ZIP archive does not have correct permissions
chmod +x "${SERVER_BINARY}"

# Force data path to be writable
chown -R gameserver:gameserver /data

# Cleanup fifo if already exists
[ -e /home/gameserver/terraria_cmd ] && rm -f /home/gameserver/terraria_cmd

exec /usr/local/bin/gosu gameserver terraria-docker_linux_amd64 -- \
	${SERVER_BINARY} -config /data/config.ini "$@"
