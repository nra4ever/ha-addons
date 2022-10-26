# Home Assistant Add-on: FRP - Fast Reverse Proxy

## Installation

Follow these steps to get the add-on installed on your system:

1. Navigate in your Home Assistant frontend to **Supervisor** -> **Add-on Store**.
2. Find the "FRP" add-on and click it.
3. Click on the "INSTALL" button.

## How to use

This addon is designed to work with the official NGINX and Let's Encrypt Community Addons, which in conjuction with an external server allows you to access Home Assistant remotely without opening a port or even behind one or multiple NATs.

1. Create an frp server, using the following example to build your own configuration, please ensure to replace the variables below with your own values. Any additional information on how to configure frps can be found [at the original projects README.](https://github.com/fatedier/frp/blob/dev/README.md). Additionally, ensure ports 80 and 443 are open on the server.
```
    [common]
    bind_port = 7070
    token = $YOUR_TOKEN
    subdomain_host = $YOUR_FQDN
    vhost_http_port = 80
    vhost_https_port = 443
    tls_enable = true
    tls_cert_file = $YOUR_SERVER_CERT
    tls_key_file = $YOUR_SERVER_KEYFILE
    tls_trusted_ca_file = $YOUR_CA
```

2. Upload your client certificate and key, along with the CA, to your Home Assistant's "ssl" directory.

3. Configure the addon options with your servers IP and port, token, subdomain and certificate information.

4. Start the addon.

## PLEASE NOTE

Please shutdown the NGINX server prior to attempting to renew/lease a Let's Encrypt certificate.

## Configuration Options

### Option: `server_address` (required)

The IP address of the FRP server.

### Option: `server_address` (required)

The port configured on the FRP server.

### Option: `token` (required)

The token (password) configured on the FRP server.

### Option: `tls_cert_file` (required)

The client certificate for the FRP server.

### Option `tls_key_file` (required)

The client key file for the FRP server.

### Option `tls_trusted_ca_file` (required)

The certificate authority for the FRP server.

### Option `subdomain` (required)

The subdomain for the HA instance (for example if subdomain is hass and domain is example.com, your HA instance would be accessible at https://hass.example.com.)
