#! /usr/bin/env bash

# Set the region
export AWS_REGION="us-east-1"

# Get the script directory end set directory paths
BIN_DIR="$(dirname "$(realpath "$0")")"
cd "$BIN_DIR/.."
ROOT_DIR="`pwd`"
ENV_DIR="$ROOT_DIR/sandbox_environments"
SETUP_DIR="$ROOT_DIR/.sandbox_setup"
ANSIBLE_CONFIG_DIR="$ROOT_DIR/../application/non-containerized-components/bsm-desktop"

# Check script input arguments
if [[ $# -ne 2 ]]
  then
    echo "Usage: sandbox_ansible_playbook <deploy|undeploy> <sandbox_environment_dir_name>"
    echo "E.g.: 'sandbox_ansible_playbook deploy us-east-1-focus-dev'" 
    exit 1
fi

# Check the existence of '.sandbox_setup' and 'sandbox_environments' directories
cd "$ROOT_DIR"
if [[ ( ! -d "./.sandbox_setup" ) || ( ! -d "./sandbox_environments" ) ]] 
    then
        echo "Directory '.sandbox_setup' or directory 'sandbox_environments' does not exist in $ROOT_DIR!"
        exit 2
fi

# Check the existence of 'ansible_inventory' in the provided directory
cd "$ENV_DIR"
if [[ ! -d "./$2/ansible_inventory" ]] 
    then
        echo "Directory 'ansible_inventory' does not exist in $ENV_DIR/$2/!"
        exit 2
fi

# Source Sandbox env file (general sandbox env vars, e.g.: IP address of linux bastion etc.)

source ../.sandbox_setup/sandbox_env

# Copy Ansible playbook to AWS linux bastion
####################################################################################################

# Delete existing contents of ansible playbook dir on linux bastion:

echo
echo "Connecting to: ${LINUX_BASTION_HOST}"
echo "Cleaning and creating ansible playbook directory: ${ANSIBLE_DIR}/${2}"

ssh -i "${PRIVATE_KEY_PATH}" ubuntu@${LINUX_BASTION_HOST} "rm -rf ${ANSIBLE_DIR}/${2} && mkdir ${ANSIBLE_DIR}/${2}"

# Copy ansible playbook from repo to linux bastion:
cd $ANSIBLE_CONFIG_DIR
tar czf ${BIN_DIR}/config.tar.gz .

cd $ENV_DIR/${2}/ansible_inventory/
tar czf ${BIN_DIR}/inventory.tar.gz .

echo "Transfering ansible playbook and inventory: config.tar.gz, inventory.tar.gz"
scp -q -o LogLevel=QUIET -i "${PRIVATE_KEY_PATH}" ${BIN_DIR}/*.tar.gz ubuntu@${LINUX_BASTION_HOST}:${ANSIBLE_DIR}/${2}/
rm ${BIN_DIR}/*.tar.gz

echo "Unpacking config.tar.gz and inventory.tar.gz..."
ssh -t -i "${PRIVATE_KEY_PATH}" ubuntu@${LINUX_BASTION_HOST} "cd ${ANSIBLE_DIR}/${2} && tar xf config.tar.gz && tar xf inventory.tar.gz --directory inventory/"
echo
echo "cd ${ANSIBLE_DIR}/${2}"
echo
echo
echo "================================================================================================"

## Execute ansible-playbook deploy|undeploy for a given environment (ansible_inventory):
case "$1" in

    "deploy")
    echo "ansible-playbook bsm.yml --vault-password-file <pwd_file> -e 'action=deploy' -i inventory/hosts"
    echo "================================================================================================"
    echo
    ssh -t -i "${PRIVATE_KEY_PATH}" ubuntu@${LINUX_BASTION_HOST} "cd ${ANSIBLE_DIR}/${2} && ansible-playbook bsm.yml --vault-password-file ${ANSIBLE_DIR}/.vp -e 'action=deploy' -i inventory/hosts"
    echo
    ;;

    "undeploy")
    echo "ansible-playbook bsm.yml --vault-password-file <pwd_file> -e 'action=undeploy' -i inventory/hosts"
    echo "================================================================================================"
    echo
    ssh -t -i "${PRIVATE_KEY_PATH}" ubuntu@${LINUX_BASTION_HOST} "cd ${ANSIBLE_DIR}/${2} && ansible-playbook bsm.yml --vault-password-file ${ANSIBLE_DIR}/.vp -e 'action=undeploy' -i inventory/hosts"
    echo
    ;;

    *)
    echo "Usage: sandbox_ansible_playbook.sh <deploy|undeploy> <sandbox_environment_dir_name>";
    exit 3;
    ;;

esac