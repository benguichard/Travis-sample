#!/bin/bash
set -e

### VARIABLES ###

BUILD_DIR=$1
COMMIT=$2
BUILD_ID="$3_$4"

PACKER_DIR=$BUILD_DIR/packer
TERRAFORM_DIR=$BUILD_DIR/terraform

### PACKER AMI CREATION ###

# Template syntax checking
$TOOLS_DIR/bin/packer validate \
  -var "site_dir=$BUILD_DIR/www" \
  -var "commit=$COMMIT" \
  -var "build_id=$BUILD_ID" \
  $PACKER_DIR/website.json

# Creation and upload of the AMI
$TOOLS_DIR/bin/packer build -force \
  -var "site_dir=$BUILD_DIR/www" \
  -var "commit=$COMMIT" \
  -var "build_id=$BUILD_ID" \
  $PACKER_DIR/website.json


### TERRAFORM DEPLOYMENT ###

AMI=`jq -r '.builds[0].artifact_id[-12:]' manifest.json`

pushd $TERRAFORM_DIR
rm -rf .terraform
terraform init
terraform validate  -var "web_ami=$AMI"
terraform plan      -var "web_ami=$AMI"
terraform apply     -var "web_ami=$AMI" -auto-approve
popd
