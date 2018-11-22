#!/bin/bash
/usr/local/openresty/nginx/sbin/nginx -c /usr/local/openresty/nginx/conf/nginx.conf
/work/prometheus-nginxlog-exporter --config-file="/work/nginx.hcl" -enable-experimental
