#! /usr/bin/env bash

# Get the script directory end set directory paths
BIN_DIR="$(dirname "$(realpath "$0")")"
cd "$BIN_DIR/.."
ROOT_DIR="`pwd`"
ENV_DIR="$ROOT_DIR/sandbox_environments"
SETUP_DIR="$ROOT_DIR/.sandbox_setup"
TF_DIR="$ROOT_DIR/../infrastructure/aws-infrastructure/tf"

# Check script input arguments
if [[ $# -ne 0 ]]
  then
    echo "Usage: ./cleanup.sh"
    exit 1
fi

# Modify working tree for Sandobox deployment
cd "$TF_DIR"

# Check existence of SDL specific files is TF_DIR

if [[ ( -f "./_backend.tf" ) || ( -f "./_providers.tf" ) || ( -f "./sdl.auto.tfvars" ) ]] 
    then
        echo "File '_backend.tf', '_providers.tf' or 'sdl.auto.tfvars' already exist in $TF_DIR!"
        exit 2
fi

if [[ -f "./_backend.tf_HIDE" ]] 
    then
        mv _backend.tf_HIDE _backend.tf
        echo "File '_backend.tf_HIDE' moved back to '_backend.tf'"
fi

if [[ -f "./_providers.tf_HIDE" ]] 
    then
        mv _providers.tf_HIDE _providers.tf
        echo "File '_providers.tf_HIDE' moved back to '_providers.tf'"
fi

if [[ -f "./sdl.auto.tfvars_HIDE" ]] 
    then
        mv sdl.auto.tfvars_HIDE sdl.auto.tfvars
        echo "File 'sdl.auto.tfvars_HIDE' moved back to 'sdl.auto.tfvars'"
fi

if [[ -f "./_sandbox_backend.tf" ]] 
    then
        rm _sandbox_backend.tf
        echo "File '_sandbox_backend.tf' removed"
fi

if [[ -f "./_sandbox_providers.tf" ]] 
    then
        rm _sandbox_providers.tf
        echo "File '_sandbox_providers.tf' removed"
fi
