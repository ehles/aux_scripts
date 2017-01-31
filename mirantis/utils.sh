#!/usr/bin/env bash

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
