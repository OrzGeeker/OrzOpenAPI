#!/usr/bin/env bash
#-*- coding: utf-8 -*-

WORKING_DIR=$(git rev-parse --show-toplevel)
nginx_service_config_file=${WORKING_DIR}/scripts/nginx_service.conf

service_name=OrzOpenAPI
nginx_site_enable_dir=/etc/nginx/sites-enabled
nginx_config_file=${nginx_site_enable_dir}/${service_name}.conf

if [ -f ${nginx_config_file} ] || [ -L ${nginx_config_file} ]; then
	rm -f ${nginx_config_file} 
fi

if [ $? -eq 0 ]; then
	ln -s ${nginx_service_config_file} ${nginx_config_file} && sudo nginx -s reload
fi

 
# if you want to setup https, your can use the certbot: https://certbot.eff.org/
# on ubuntu, you can reference this article: https://certbot.eff.org/instructions?ws=nginx&os=pip


