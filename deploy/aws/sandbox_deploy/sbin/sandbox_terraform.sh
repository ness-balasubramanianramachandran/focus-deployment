#! /usr/bin/env bash

# Set the region
export AWS_REGION="us-east-1"

# Get the script directory end set directory paths
BIN_DIR="$(dirname "$(realpath "$0")")"
cd "$BIN_DIR/.."
ROOT_DIR="`pwd`"
ENV_DIR="$ROOT_DIR/sandbox_environments"
SETUP_DIR="$ROOT_DIR/.sandbox_setup"
TF_DIR="$ROOT_DIR/../infrastructure/aws-infrastructure/tf"

# Check script input arguments
if [[ $# -ne 2 ]]
  then
    echo "Usage: sandbox_terraform <plan|apply|destroy> <sandbox_environment_dir_name>"
    echo "E.g.: 'sandbox terraform plan us-east-1-focus-dev'" 
    exit 1
fi

# Check the existence of '.sandbox_setup' and 'sandbox_environments' directories
cd "$ROOT_DIR"
if [[ ( ! -d "./.sandbox_setup" ) || ( ! -d "./sandbox_environments" ) ]] 
    then
        echo "Directory '.sandbox_setup' or directory 'sandbox_environments' does not exist in $ROOT_DIR!"
        exit 2
fi

# Check the existence of 'backend.conf' and 'base.tfvars' in the provided directory
cd "$ENV_DIR"
if [[ ( ! -f "./$2/backend.conf" ) || ( ! -f "./$2/base.tfvars" ) ]] 
    then
        echo "File 'backend.conf' or file 'base.tfvars' does not exist in $ENV_DIR/$2/!"
        exit 2
fi

# Get AWS SSO credentials for the sandbox account. Previously you need to configure aws sso on your workstation:  aws configure sso  (use 'sandbox-admin' as the profile name)
#aws sso login

# Modify working tree for Sandobox deployment
####################################################################################################


cd "$TF_DIR"

# Check existence of SDL specific files is TF_DIR

if [[ ( ! -f "./_backend.tf" ) || ( ! -f "./_providers.tf" ) || ( ! -f "./sdl.auto.tfvars" ) ]] 
    then
        echo "File '_backend.tf', '_providers.tf' or 'sdl.auto.tfvars' does not exist in $TF_DIR!"
        exit 2
fi

# Define hide and unhide functions:

function hide {
    mv _backend.tf _backend.tf_HIDE
    mv _providers.tf _providers.tf_HIDE
    mv sdl.auto.tfvars sdl.auto.tfvars_HIDE
    cp "$SETUP_DIR/sandbox_backend.tf" "$TF_DIR/_sandbox_backend.tf"
    cp "$SETUP_DIR/sandbox_providers.tf" "$TF_DIR/_sandbox_providers.tf"
}

function unhide {
    rm "$TF_DIR/_sandbox_backend.tf"
    rm "$TF_DIR/_sandbox_providers.tf"
    mv _backend.tf_HIDE _backend.tf
    mv _providers.tf_HIDE _providers.tf
    mv sdl.auto.tfvars_HIDE sdl.auto.tfvars
}

# Hide SDL specific config files: _backend.tf, _providers.tf and sdl.auto.tfvars
echo
echo "Starting terraform $1 for sandbox environment $2 ..."
echo "Hiding SDL specific config files: _backend.tf, _providers.tf and sdl.auto.tfvars"
echo "Adding Sandbox specific config files: _sandbox_backend.tf and _sandbox_providers.tf"
hide

# Clean local .terraform from previous "terraform init" commands (to be able to switch between different backend states)
#rm -rf .terraform .terraform.lock.hcl

# Set location of .terraform directory to environment specific directory (it keeps env specific backend info):
#export TF_DATA_DIR="/${ENV_DIR}/$2/.terraform"

# Execute plan|apply|destroy for a given environment (backend.conf and base.tfvars)
case "$1" in

    "plan")
    terraform init -backend-config "$ENV_DIR/$2/backend.conf" -reconfigure && terraform validate && terraform plan -var-file "$ENV_DIR/$2/base.tfvars"
    #export TF_DATA_DIR="`echo $TF_DATA_DIR | sed -e 's/\\//\\\/g' -e 's/^\\\c/C:/g'`"
    #terraform init -backend-config "$ENV_DIR/$2/backend.conf" -reconfigure
    env | grep TF
    terraform plan -var-file "$ENV_DIR/$2/base.tfvars"
    echo
    echo "terraform $1 for sandbox environment $2 ..."
    echo "Unhiding SDL specific config files: _backend.tf, _providers.tf and sdl.auto.tfvars"
    echo "Removing Sandbox specific config files: _sandbox_backend.tf and _sandbox_providers.tf"
    unhide
    ;;

    "apply")
    terraform init -backend-config "$ENV_DIR/$2/backend.conf" -reconfigure && terraform validate && terraform apply -var-file "$ENV_DIR/$2/base.tfvars" -auto-approve
    echo
    echo "Finishing terraform $1 for sandbox environment $2 ..."
    echo "Unhiding SDL specific config files: _backend.tf, _providers.tf and sdl.auto.tfvars"
    echo "Removing Sandbox specific config files: _sandbox_backend.tf and _sandbox_providers.tf"    
    unhide
    ;;

    "destroy")
    terraform init -backend-config "$ENV_DIR/$2/backend.conf" -reconfigure && terraform validate && terraform destroy -var-file "$ENV_DIR/$2/base.tfvars" -auto-approve
    echo
    echo "Finishing terraform $1 for sandbox environment $2 ..."
    echo "Unhiding SDL specific config files: _backend.tf, _providers.tf and sdl.auto.tfvars"
    echo "Removing Sandbox specific config files: _sandbox_backend.tf and _sandbox_providers.tf"    
    unhide
    ;;

    *)
    echo "Usage: sandbox_terraform.sh <plan|apply|destroy> <sandbox_environment_dir_name>";
    echo
    echo "Finishing terraform $1 for sandbox environment $2 ..."
    echo "Unhiding SDL specific config files: _backend.tf, _providers.tf and sdl.auto.tfvars"
    echo "Removing Sandbox specific config files: _sandbox_backend.tf and _sandbox_providers.tf"
    unhide
    exit 3;
    ;;

esac