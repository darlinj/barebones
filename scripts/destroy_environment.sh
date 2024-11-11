#!/bin/bash
if [ -z "$1" ]; then
    echo "Please provide an environment to this script e.g. prod.  This should be the name of a tfvars file in the infrastructure directory"
    exit 1
fi
ENV=$1
SCRIPT_DIR=$(dirname "$(realpath "$0")")
terraform -chdir=${SCRIPT_DIR}/../infrastructure init -reconfigure -backend-config="key=terraform-state-${ENV}"
terraform -chdir=${SCRIPT_DIR}/../infrastructure destroy -var-file=${ENV}.tfvars -var="environment=${ENV}"
