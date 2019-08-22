#!/usr/bin/env bash

#sed -i -e "s/%NGINX_PORT%/${NOMAD_PORT_nginx}/g" /etc/nginx/conf.d/default.conf
envsubst < /etc/nginx/conf.d/nginx.conf.template > /etc/nginx/conf.d/default.conf
exec nginx -g 'daemon off;'
