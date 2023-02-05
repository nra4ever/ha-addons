#!/usr/bin/with-contenv bashio
CLIENT_ARCH=$(apk --print-arch)
REMOTE_ADDRESS=$(bashio::config 'remote_address')
LOCAL_ADDRESS=$(bashio::config 'local_address_ssl')
LOCAL_ADDRESS_INSEC=$(bashio::config 'local_address_http')
TOKEN=$(bashio::config 'token')
CA_FILE=$(bashio::config 'trusted_root')
HOSTNAME=$(bashio::config 'hostname')
NAME1=$(bashio::config 'name_ssl')
NAME2=$(bashio::config 'name_http')

echo "[client]
remote_addr = \"$REMOTE_ADDRESS\"
default_token = \"$TOKEN\"

[client.services.$NAME1]
local_addr = \"$LOCAL_ADDRESS\"

[client.services.$NAME2]
local_addr = \"$LOCAL_ADDRESS_INSEC\"

[client.transport]
type = \"tls\"

[client.transport.tls]
trusted_root = \"/ssl/$CA_FILE\" 
 hostname = \"$HOSTNAME\" " > /rathole-$CLIENT_ARCH/client.toml

cd /rathole-$CLIENT_ARCH

chmod +x rathole
./rathole client.toml
