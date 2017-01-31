#!/bin/bash

# source Variable definitions
SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
source ${SCRIPTPATH}/config.sh

RECREATE=$1
echo ${RECREATE}

###############################################################################
# Funcs
###############################################################################
function create_venv {
    log "[create venv] ${VENV_PATH}"
    virtualenv --no-site-package ${VENV_PATH}
}

function create_db {
    log "[create database] ${DEVOPS_DB_NAME}"
    sudo -u postgres dropdb fuel_devops
    sudo -u postgres createdb fuel_devops -O fuel_devops
    django-admin.py syncdb --settings=devops.settings
    django-admin.py migrate devops --settings=devops.settings --noinput
}

function install_requirements {
    log "[install requirements]"
    pip install -U pip
    pip install setuptools
    pip install git+https://github.com/openstack/fuel-devops.git@${DEVOPS_RELEASE} --upgrade
    pip install psycopg2
    for dep in ${DEPS_FILES[@]}; do
        log "install from ${dep}"
        pip install -r "${dep}" --upgrade
    done
}

function clone_sources {
    log "[Clone sources] ${SRC_PATH}"
    cd ${WORK_PATH}
    git clone ${SRC_REPO} ${SRC_PATH}
    cd ${SRC_PATH}
    git checkout ${SRC_BRANCH}
    git submodule init
    git submodule update  # --remote
}

###############################################################################
###############################################################################
if [ ! -d "${WORK_PATH}" ]; then
    log "[Create work folder] ${WORK_PATH}"
    mkdir -p ${WORK_PATH}
fi

if [ ! -d "${SRC_PATH}" ]; then
    clone_sources
else
    log "[Source already exists]"
fi

if [ ! -d "${VENV_PATH}" ]; then
    create_venv
    with_venv "install_requirements"
else
    log "[Virtual env already exists] ${VENV_PATH}"
fi


if [ ! -f "${DEVOPS_DB_NAME}" ]; then
    with_venv "create_db"
else
    log "[Database already exists] ${DEVOPS_DB_NAME}"
fi



log "[done]"
