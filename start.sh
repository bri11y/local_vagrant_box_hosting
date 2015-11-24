#!/bin/bash
set -e
cd `dirname $0`
. .env

# Workaround since we can't use environmental variables in the nginx configuration
sed -re "s@\\\$cfg_port@$cfg_port@g" -e "s@\\\$cfg_hostname@$cfg_hostname@g" conf.d/nginx-vagrant-boxes.template > conf.d/nginx-vagrant-boxes.conf

echo 
echo "Starting nginx-vagrant-boxes"
docker run -d -p $cfg_port:$cfg_port \
  -v /root/nginx_vagrant_boxes/html:/usr/share/nginx/html:ro \
  -v /root/nginx_vagrant_boxes/conf.d/:/etc/nginx/conf.d/:ro \
  --name nginx-vagrant-boxes nginx
