#!/bin/bash
if [ -z "$1" ]; then
    echo "Please provide an environment to this script e.g. prod.  This should be the name of a tfvars file in the infrastructure directory"
    exit 1
fi
ENV=$1
SCRIPT_DIR=$(dirname "$(realpath "$0")")
terraform -chdir=${SCRIPT_DIR}/../infrastructure init -reconfigure -backend-config="key=terraform-state-${ENV}"

BUCKET_NAME=$(terraform -chdir=infrastructure output -raw bucket_name)
aws s3 sync ${SCRIPT_DIR}/../apps/website/dist s3://${BUCKET_NAME} --exclude index.html
aws s3 sync ${SCRIPT_DIR}/../apps/website/dist s3://${BUCKET_NAME} --exclude "*" --include index.html --metadata-directive REPLACE --cache-control no-cache

if [ $? -eq 0 ]; then
    echo "Files successfully uploaded to ${BUCKET_NAME}"
else
    echo "Failed to upload files to ${BUCKET_NAME}"
fi
