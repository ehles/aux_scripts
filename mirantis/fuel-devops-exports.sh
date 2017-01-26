#!/bin/bash
###############################################################################
# Local variables
###############################################################################
DEVOPS_RELEASE="3.0.3"
QA_DEPS_FILE="https://raw.githubusercontent.com/openstack/fuel-qa/stable/mitaka/fuelweb_test/requirements.txt"
SRC_REPO="https://github.com/openstack/fuel-plugin-contrail.git"
SRC_FOLDER="./fuel-plugin-contrail"

###############################################################################
# Exports
###############################################################################
export WORK_PATH="~/work/dpdk/tpi76/fuel_devops"
export VENV_PATH="${WORK_PATH}/devops_venv_${DEVOPS_RELEASE}"
export DEVOPS_DB_NAME="${WORK_PATH}/db.sqlite"
export DEVOPS_DB_ENGINE="django.db.backends.sqlite3"



###############################################################################
# Funcs
###############################################################################
function log {
    CLR='\033[1;33m'  # Text Color
    NC='\033[0m'      # No Color
    printf "${CLR}${1}${NC}\n"
}

function with_venv {
    log "[activate venv ] ${VENV_PATH}"
    source ${VENV_PATH}/bin/activate
    # call function param
    $1
    log "[deactivate venv]"
    deactivate
}

function create_venv {
    log "[create venv] ${VENV_PATH}"
    virtualenv --no-site-package ${VENV_PATH}
}

function create_db {
    log "[create database] ${DEVOPS_DB_NAME}"
    django-admin.py syncdb --settings=devops.settings
    django-admin.py migrate devops --settings=devops.settings
}

function install_requirements {
    log "[install requirements] ${QA_DEPS_FILE}"
    pip install -U pip
    pip install setuptools
    pip install git+https://github.com/openstack/fuel-devops.git@${DEVOPS_RELEASE} --upgrade
    pip install -r "${QA_DEPS_FILE}" --upgrade
}

function clone_sources {
    log "[Clone sources] ${WORK_PATH}/${SRC_FOLDER}"
    cd ${WORK_PATH}
    git clone ${SRC_REPO} ${SRC_FOLDER}
}

###############################################################################
###############################################################################

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


if [ ! -d "${WORK_PATH}/${SRC_FOLDER}" ]; then
    clone_sources
else
    log "[Source already exists]"
fi