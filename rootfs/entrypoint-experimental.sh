#!/bin/bash

set -euo pipefail

/entrypoint.sh true

GITIT_BOOTSTRAP_THEME_DIR=/opt/gitit-bootstrap-theme
GITIT_STATIC_DIR="${GITIT_WORK_DIR}/static"
GITIT_TEMPLATES_DIR="${GITIT_WORK_DIR}/templates"

if [ ! -e "${GITIT_STATIC_DIR}" ]
then
    cp -r "${GITIT_BOOTSTRAP_THEME_DIR}/out/static" "${GITIT_STATIC_DIR}"
    chown -R "${GITIT_USER}:${GITIT_USER}" "${GITIT_STATIC_DIR}"
fi

if [ ! -e "${GITIT_TEMPLATES_DIR}" ]
then
    cp -r "${GITIT_BOOTSTRAP_THEME_DIR}/out/templates" "${GITIT_TEMPLATES_DIR}"
    chown -R "${GITIT_USER}:${GITIT_USER}" "${GITIT_TEMPLATES_DIR}"
fi

cd "${GITIT_WORK_DIR}"

if [ ${#@} -eq 0 ]
then
    exec gosu "${GITIT_USER}" gitit -f "${GITIT_CONF}"
else
    exec "${@}"
fi
