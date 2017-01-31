#!/usr/bin/env bash

###############################################################################
# Source Variable definitions
###############################################################################
# config
SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
source ${SCRIPTPATH}/config.sh

# credentials
if [ -f "config_credentials.sh" ]; then
    echo "Use config credentials"
    source config_credentials.sh
fi


###############################################################################
# TEST PARAMS
###############################################################################
TEST_GROUP_NAME="contrail_bvt"
ENV_KEEP_AFTER=true  # true/false
ENV_KEEP_PREV=true  # true/false
JOB_NAME="contrail"


PARAMS="-t test -w ${SRC_PATH} -V ${VENV_PATH} -i ${ISO_PATH} -j ${JOB_NAME}"

if [ ${ENV_KEEP_AFTER} ]; then
    PARAMS="${PARAMS} -K"
fi

if [ ${ENV_KEEP_PREV} ]; then
    PARAMS="${PARAMS} -k"
fi

PARAMS="${PARAMS} -o --group=${TEST_GROUP_NAME}"

# ./plugin_test/utils/jenkins/system_tests.sh -t test -k -K -w "${SRC_PATH}" -V "${VENV_PATH}" -i "${ISO_PATH}" -j contrail -o --group=contrail_bvt

cd "${SRC_PATH}"
echo "Current dir `pwd`"
echo "Test params: ${PARAMS}"
./plugin_test/utils/jenkins/system_tests.sh ${PARAMS}

