#!/usr/bin/env bash

# config
SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

source ${SCRIPTPATH}/utils.sh
source ${SCRIPTPATH}/config.sh




# Cleanup networks
for net in `virsh net-list --all | grep ${ENV_NAME} | grep -v Name| awk '{print $1}'`; do
    virsh net-undefine ${net}
done

# Cleanup snapshots
for vm in `virsh list --all | greo ${ENV_NAME} | grep -v Name| awk '{print $2}'`; do
    virsh snapshot-delete ${vm} --current
done


for vm in `virsh list --all | greo ${ENV_NAME} | grep -v Name| awk '{print $2}'`; do
    virsh undefine ${vm}
done