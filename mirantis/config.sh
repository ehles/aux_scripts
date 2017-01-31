#!/usr/bin/env bash
SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
source ${SCRIPTPATH}/utils.sh

export WORK_PATH=~/work/dpdk/tpi76/fuel_devops/data

###############################################################################
# Local variables
###############################################################################
DEVOPS_RELEASE="3.0.2"
SRC_REPO="https://github.com/openstack/fuel-plugin-contrail.git"
SRC_PATH="${WORK_PATH}/fuel-plugin-contrail"
SRC_BRANCH="origin/stable/5.0.0"
#SRC_BRANCH="master"
DEPS_FILES=(
    "https://raw.githubusercontent.com/openstack/fuel-qa/stable/mitaka/fuelweb_test/requirements.txt"
    "${SRC_PATH}/plugin_test/requirement.txt"
)

###############################################################################
# Exports
###############################################################################
export ENV_NAME=80-contrail

export VENV_PATH="${WORK_PATH}/devops_venv_${DEVOPS_RELEASE}"
#export DEVOPS_DB_NAME="${WORK_PATH}/db.sqlite"
#export DEVOPS_DB_ENGINE="django.db.backends.sqlite3"


###############################################################################
# Baremetal Access Credentials
###############################################################################
export BM_IPMI_USER='ipmi_user'
export BM_IPMI_PASSWORD='ipmi_password'
export BM_IPMI_ADDR='ipmi_host_address'
export BM_TARGET_MACS='MAC1;MAC2'
export BM_HOST_BRIDGE_INTERFACES='eth1:10.109.0.0/24;eth2:10.109.4.0/24'

###############################################################################
# Test files and configs.
###############################################################################
export CONTRAIL_PLUGIN_PATH="${WORK_PATH}/contrail-5.0-5.0.0-1.noarch.rpm"
export CONTRAIL_PLUGIN_PACK_UB_PATH="${WORK_PATH}/contrail-install-packages_3.1.0.0-25.deb"
export ISO_PATH="/storage/downloads/MirantisOpenStack-9.0.iso"


export MIRROR='http://mirror.seed-cz1.fuel-infra.org'
export MIRROR_UBUNTU='deb http://mirror.seed-cz1.fuel-infra.org/pkgs/ubuntu/ trusty main universe multiverse | deb http://mirror.seed-cz1.fuel-infra.org/pkgs/ubuntu/ trusty-updates main universe multiverse'

export KVM_USE='True'
export DISABLE_SSL='True'


export ADMIN_NODE_MEMORY=4096
export ADMIN_NODE_CPU=4
export SLAVE_NODE_MEMORY=4096
export SLAVE_NODE_CPU=4
export NODE_VOLUME_SIZE=350
export NODES_COUNT=10
