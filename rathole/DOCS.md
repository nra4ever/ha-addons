# Home Assistant Add-on: rathole 

## Installation

Follow these steps to get the add-on installed on your system:

1. Navigate in your Home Assistant frontend to **Supervisor** -> **Add-on Store**.
2. Find the "Rathole" add-on and click it.
3. Click on the "INSTALL" button.

## How to use

This addon is designed to work with the official NGINX and Let's Encrypt Community Addons, which in conjuction with an external server allows you to access Home Assistant remotely without opening a port or even behind one or multiple NATs.

## PLEASE NOTE

Please shutdown the NGINX server prior to attempting to renew/lease a Let's Encrypt certificate.

## Configuration Options

### Option: `remote_address` (required)

The domain or ip and port of the rathole server

### Option: `name_ssl` (required)

The name of the secure profile

### Option: `local_address_ssl` (required)

The SSL IP:port to forward 

### Option: `remote_address` (required)

The name of the insecure profile (used for LE certificate leasing)

### Option: `local_address_http` (required)

The SSL IP:port to forward 

### Option: `token` (required)

The token (password) configured on the rathole server.

### Option `trusted_root` (required)

The certificate authority for the rathole server.

### Option `hostname` (required)

The Hostname homain of the rathole server
