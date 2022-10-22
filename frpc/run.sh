#!/usr/bin/with-contenv bashio
CLIENT_ARCH=$(apk --print-arch)
SERVER_ADDRESS=$(bashio::config 'server_address')
SERVER_PORT=$(bashio::config 'server_port')
TOKEN=$(bashio::config 'token')
TLS_CERT_FILE=$(bashio::config 'tls_cert_file')
TLS_KEY_FILE=$(bashio::config 'tls_key_file')
TLS_TRUSTED_CA_FILE=$(bashio::config 'tls_trusted_ca_file')
SUBDOMAIN=$(bashio::config 'subdomain')


echo "[common]
server_addr = $SERVER_ADDRESS
server_port = $SERVER_PORT
token = $TOKEN
tls_enable = true
tls_cert_file = /ssl/$TLS_CERT_FILE
tls_key_file = /ssl/$TLS_KEY_FILE
[$SUBDOMAIN]
type = https
local_port = 443
remote_port = 443
use_encryption = true
use_compression = true
subdomain = $SUBDOMAIN
[$SUBDOMAIN-unsec]
type = http
local_port = 80
remote_port = 80
use_encryption = true
use_compression = true
subdomain = $SUBDOMAIN" > /frp-$CLIENT_ARCH/frpc.ini

cd /frp-$CLIENT_ARCH

chmod +x frpc
./frpc -c frpc.ini
