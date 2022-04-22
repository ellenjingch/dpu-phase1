#!/bin/sh
set -e

echo "Generating envoy.yaml config file..."
cat /tmpl/envoy.yaml.tmpl | envsubst \$ENVOY_LB_ALG,\$SERVICE_NAME,\$SERVICE_PORT > /etc/envoy.yaml

echo "Starting Envoy..."
/usr/local/bin/envoy -c /etc/envoy.yaml -l debug