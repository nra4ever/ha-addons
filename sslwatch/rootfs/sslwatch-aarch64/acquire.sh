#!/bin/bash

echo $(bashio::config 'private-key') > key
chmod 600 key
server_name=$(bashio::config 'remote-address')
subdomain=$(bashio::config 'subdomain')
# Set the interval in seconds for checking the version
interval=3600

# Set the target server name
server_name=fok

# Set the destination path for the remote key file
remote_key_file=/etc/nginx/ssl/$subdomain.guth3d.com/*

# Get the current version
curr_ver=$(cat version)

while true; do
    # Wait for the specified interval
    sleep $interval

    # Get the latest version
    latest_ver=$(curl http://162.19.65.207:8783/get_version/$subdomain | jq '.version')

    # Check if the version has changed
    if [[ $latest_ver != $curr_ver ]]; then
        # Copy the SSL keys to the local machine using SCP
        scp -i key debian@$server_name:$remote_key_file /ssl/

        # Update the current version
        curr_ver=$latest_ver
        echo $latest_ver > /version
        echo "SSL keys updated from $server_name"
    fi
done