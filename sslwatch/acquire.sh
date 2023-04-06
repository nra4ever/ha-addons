#!/usr/bin/with-contenv bashio
mkdir ~/.ssh
touch ~/.ssh/known_hosts
key=/ssl/prikey
eval `ssh-agent -s`
ssh-add $key    
server_name=$(bashio::config 'remote_address')
ssh-keyscan $server_name >> ~/.ssh/known_hosts
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

echo $(ssh-add -l)
echo $(ls -al ~)

while true; do
    # Get the latest     version
    version_output=$(curl http://$server_name:8783/get_version/$subdomain)
    latest_ver=$(echo "$version_output" | grep -o "\"version\":.*" | sed -e 's/^.*: //' -e 's/[},]*$//')

    # Check if the version has changed
    if [[ $latest_ver != $curr_ver ]]; then
        # Copy the SSL keys to the local machine using SCP
        rsync -PavL -e "ssh -i fok2c" debian@$server_name:$remote_key_file /ssl/
        # Update the current version
        curr_ver=$latest_ver
        echo $latest_ver > /version
        echo "SSL keys updated from $server_name"
    fi
    # Wait for the specified interval
    sleep $interval
done