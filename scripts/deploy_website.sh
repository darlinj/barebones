#!/bin/bash
BUCKET_NAME=$(terraform -chdir=infrastructure output -raw bucket_name)
SCRIPT_DIR=$(dirname "$(realpath "$0")")
aws s3 sync ${SCRIPT_DIR}/../apps/website/dist s3://${BUCKET_NAME} --exclude index.html
aws s3 sync ${SCRIPT_DIR}/../apps/website/dist s3://${BUCKET_NAME} --exclude "*" --include index.html --metadata-directive REPLACE --cache-control no-cache

if [ $? -eq 0 ]; then
    echo "Files successfully uploaded to ${BUCKET_NAME}"
else
    echo "Failed to upload files to ${BUCKET_NAME}"
fi
