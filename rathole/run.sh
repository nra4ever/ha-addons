#!/usr/bin/with-contenv bashio
CLIENT_ARCH=$(apk --print-arch)
REMOTE_ADDRESS=$(bashio::config 'remote_address')
LOCAL_ADDRESS=$(bashio::config 'local_address_ssl')
TOKEN=$(bashio::config 'token')
KEY=$(bashio::config 'public_key')
NAME1=$(bashio::config 'name_ssl')

echo "[client]
remote_addr = \"$REMOTE_ADDRESS\"
default_token = \"$TOKEN\"

[client.services.$NAME1]
local_addr = \"$LOCAL_ADDRESS\"

[client.transport]
type = \"noise\"

[client.transport.noise]
remote_public_key = \"$KEY\" " > /rathole-$CLIENT_ARCH/client.toml

cd /rathole-$CLIENT_ARCH

chmod +x rathole
./rathole client.toml

