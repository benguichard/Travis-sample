#!/bin/bash
set -e

### VARIABLES ###

BUILD_DIR=$1
COMMIT=$2
BUILD_ID="$3_$4"

PACKER_DIR=$BUILD_DIR/packer

### PACKER AMI CREATION ###

# Template syntax checking
$TOOLS_DIR/bin/packer validate \
  -var "site_dir=$BUILD_DIR/www" \
  -var "commit=$COMMIT" \
  -var "build_id=$BUILD_ID" packer.json || exit 1

# Creation and upload of the AMI
$TOOLS_DIR/bin/packer build -force \
  -var "site_dir=$BUILD_DIR/www" \
  -var "commit=$COMMIT" \
  -var "build_id=$BUILD_ID" \
  $PACKER_DIR/packer.json || exit 1

### TERRAFORM DEPLOYMENT ###

AMI=`jq -r '.builds[0].artifact_id[-12:]' manifest.json`
echo $AMI
