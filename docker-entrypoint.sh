#!/bin/sh
set -e

VITE_GRAPHQL_URI="${VITE_GRAPHQL_URI:-http://120.26.174.241:8080/graphql}"
VITE_SERVER_URI="${VITE_SERVER_URI:-http://120.26.174.241:8080}"
NGINX_PORT="${NGINX_PORT:-8080}"
BACKEND_PORT="${BACKEND_PORT:-8082}"

find /usr/share/nginx/html/assets -name '*.js' -exec sed -i \
  "s|__VITE_GRAPHQL_URI_PLACEHOLDER__|${VITE_GRAPHQL_URI}|g" {} +
find /usr/share/nginx/html/assets -name '*.js' -exec sed -i \
  "s|__VITE_SERVER_URI_PLACEHOLDER__|${VITE_SERVER_URI}|g" {} +
sed -i "s|__NGINX_PORT__|${NGINX_PORT}|g" /etc/nginx/conf.d/default.conf
sed -i "s|__BACKEND_PORT__|${BACKEND_PORT}|g" /etc/nginx/conf.d/default.conf

echo "Configured VITE_GRAPHQL_URI=${VITE_GRAPHQL_URI}"
echo "Configured VITE_SERVER_URI=${VITE_SERVER_URI}"
echo "Configured NGINX_PORT=${NGINX_PORT}"
echo "Configured BACKEND_PORT=${BACKEND_PORT}"
exec nginx -g 'daemon off;'
