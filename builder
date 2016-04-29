#!/bin/bash

# set alias
shopt -s expand_aliases
alias python=python3
alias pip=pip3
alias pyvenv=virtualenv

# get latest dc/os tools
cd $HOME
git clone https://github.com/dcos/dcos
cd dcos/

# find or build the config
if [ -f "${CONFIG_SHARED_PATH}" ]
then
  echo "# use shared dcos-config ${CONFIG_SHARED_PATH}"
  cp ${CONFIG_SHARED_PATH} /root/dcos/dcos-release.config.yaml
else
  echo "# generate dcos-config"
  cat <<EOF > dcos-release.config.yaml
storage:
  local:
    kind: ${CONFIG_KIND}
    path: ${RELEASE_ARTIFACTS_PATH}
options:
  preferred: ${CONFIG_PREFERRED}
EOF
fi

# create the release folder if isnt exist
[ -d "${RELEASE_ARTIFACTS_PATH}" ] || mkdir -p ${RELEASE_ARTIFACTS_PATH}

# set build env
pyvenv ../env
source ../env/bin/activate

# run dc/os builder
echo "# exec prep_local"
./prep_local
echo "# exec release ${RELEASE_ACTION} ${RELEASE_CHANNEL} ${RELEASE_TAG}"
release ${RELEASE_ACTION} ${RELEASE_CHANNEL} ${RELEASE_TAG}
