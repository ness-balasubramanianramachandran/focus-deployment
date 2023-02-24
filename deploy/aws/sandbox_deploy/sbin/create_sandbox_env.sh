#! /usr/bin/env bash

# Get the script directory end set directory paths
BIN_DIR="$(dirname "$(realpath "$0")")"
cd "$BIN_DIR/.."
ROOT_DIR="`pwd`"
ENV_DIR="$ROOT_DIR/sandbox_environments"
SETUP_DIR="$ROOT_DIR/.sandbox_setup"
TF_DIR="$ROOT_DIR/../../infrastructure/aws-infrastructure/tf"

# Check script input arguments
if [[ $# -ne 1 ]]
  then
    echo
    echo "Usage: ./create_sandbox_env.sh <region>-<application>-<environment>"
    echo "E.g.: ./create_sandbox_env.sh us-east-1-focus-devops_e5658831"
    echo "The previous example would implicitly set the environment_type variable to 'devops_e5658831' and create a dedicated state file with the same name in s3 backend"
    echo "Do not use '-' in application or environment"
    exit 1
fi

# Get region, app and environment_type from input argument

REGION="`echo $1 | cut -d - -f 1,2,3`"
APP="`echo $1 | cut -d - -f 4`"
ENV_NAME="`echo $1 | cut -d - -f 5`"

# Validate 

if [[ ( -z "$REGION" ) || ( -z "$APP" ) || ( -z "$ENV_NAME" ) ]]
  then
    echo
    echo "Usage: ./create_sandbox_env.sh <region>-<application>-<environment>"
    echo "E.g.: ./create_sandbox_env.sh us-east-1-focus-devops_e5658831"
    echo "The previous example would implicitly set the environment_type variable to 'devops_e5658831' and create a dedicated state file with the same name in s3 backend"
    echo "Do not use '-' in application or environment"
    exit 1
fi

# Check the existence of '.sandbox_setup' and 'sandbox_environments' directories
cd "$ROOT_DIR"
if [[ ( ! -d "./.sandbox_setup" ) || ( ! -d "./sandbox_environments" ) ]] 
    then
        echo "Directory '.sandbox_setup' or directory 'sandbox_environments' does not exist in $ROOT_DIR!"
        exit 2
fi

# Check the existence of 'backend.conf_TMPL' and 'base.tfvars_TMPL' in the .sandbox_setup dir
cd "$SETUP_DIR"
if [[ ( ! -f "./$2/backend.conf_TMPL" ) || ( ! -f "./$2/base.tfvars_TMPL" ) ]] 
    then
        echo "File 'backend.conf_TMPL' or file 'base.tfvars_TMPL' does not exist in $ENV_DIR/$2/!"
        exit 2
fi

# Get local terraform version
echo "Getting the local Terraform version..."
TF_VER="`terraform --version | grep ^Terraform`"

# Create directory for new environment 
cd "$ENV_DIR"
echo "Creating directory $1 for the new environment backend.conf and base.tfvars files..."
mkdir "$1"
cd "$1"

# Copy templates 
cp "$SETUP_DIR/"*_TMPL .

# Edit templates
echo "Editing backend.conf_TMPL and base.tfvars_TMPL..."
sed -e "s/__ENV__/$ENV_NAME/g" backend.conf_TMPL > backend.conf
sed -e "s/__ENV__/$ENV_NAME/g" -e "s/__TF_VER__/$TF_VER $ENV_NAME/g" base.tfvars_TMPL > base.tfvars

# Remove templates
rm *_TMPL
echo "Done"

echo "You can now edit your .tfvars and use: sandbox_terraform.sh plan $1"

