#!/bin/bash
if [ -z "$1" ]; then
    echo "Please provide an environment to this script e.g. prod.  This should be the name of a tfvars file in the infrastructure directory"
    exit 1
fi

SCRIPT_DIR=$(dirname "$(realpath "$0")")
ENV=$1
cd apps/website && npm run build -- --mode ${ENV}
