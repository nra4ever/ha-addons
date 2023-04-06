#!/usr/bin/with-contenv bashio
key=/ssl/prikey
server_name=$(bashio::config 'remote_address')
subdomain=$(bashio::config 'subdomain')
if [[ -f "/ssl/version" ]]; then
    curr_ver=$(cat /ssl/version)
else
    touch /ssl/version
    echo 1 > /etc/version
fi
# Set the interval in seconds for checking the version
interval=3600

# Set the destination path for the remote key file
remote_key_file="/etc/nginx/ssl/$subdomain.guth3d.com/"

while true; do
    # Wait for the specified interval
    sleep $interval

    # Get the latest version
    version_output=$(curl http://162.19.65.207:8783/get_version/$subdomain)
    latest_ver=$(echo "$version_output" | grep -o "\"version\":.*" | sed -e 's/^.*: //' -e 's/[},]*$//')

    # Check if the version has changed
    if [[ $latest_ver != $curr_ver ]]; then
        # Copy the SSL keys to the local machine using SCP
        rsync -Pav -e "ssh -i $key" debian@$server_name:$remote_key_file /ssl/
        # Update the current version
        curr_ver=$latest_ver
        echo $latest_ver > /version
        echo "SSL keys updated from $server_name"
    fi
done