#! /usr/bin/env bash

# Get the script directory end set directory paths
BIN_DIR="$(dirname "$(realpath "$0")")"
cd "$BIN_DIR/.."
ROOT_DIR="`pwd`"
ENV_DIR="$ROOT_DIR/sandbox_environments"
SETUP_DIR="$ROOT_DIR/.sandbox_setup"
TF_DIR="$ROOT_DIR/../../infrastructure/aws-infrastructure/tf"

cd "$ENV_DIR"

# list environments
ls -l | awk '{ print $9}' | cut -d/ -f1