#!/bin/bash

# Close STDERR
#exec 2<&-

if [ $# -lt 1 ]; then
  echo "Usage: $0 cluster_name"
  exit 0
fi

if [ SAHARA_URL ]; then
  TENANT_ID=$(keystone token-get |  awk '/ tenant_id / {print $4;}')
  OS_TENANT_ID=${OS_TENANT_ID:-$TENANT_ID}
  echo OS_TENANT_ID=$OS_TENANT_ID
  sa="sahara --insecure --bypass-url $SAHARA_URL/v1.1/$OS_TENANT_ID"
else
  sa="sahara --insecure"
fi

echo "Delete all trace of $1"

CUSTER_NAME=`awk '/"name"/ {print $2;}' $1/*launch_temp | sed 's/["|,]//g'`
if [ CLUSTER_NAME ]; then
  echo "Deleting cluster: $CLUSTER_NAME"
  $sa cluster-delete --name $CLUSTER_NAME
  echo "Waiting for cluster-delete ..."
  sleep 1
fi

CLUSTER_TEMPLATE=`awk '/cluster_template_id/ {print $2;}' $1/*launch_temp | sed 's/["|,]//g'`
if [ CLUSTER_TEMPLATE ]; then
  echo "Deleting cluster-template: $CLUSTER_TEMPLATE"
  $sa cluster-template-delete --id $CLUSTER_TEMPLATE
  sleep 3
fi

NG_TEMPLATE=`awk '/node_group_template_id/ {print $2;}' $1/*cluster_temp | sed 's/["|,]//g'`
if [ NG_TEMPLATE ]; then
  for ng in $NG_TEMPLATE; do
  echo "Deleting node-group-template: $NG_TEMPLATE"
    $sa node-group-template-delete --id $ng
  done
fi

echo "Deleting finished"
