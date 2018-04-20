#!/bin/bash
set -e

BUILD_DIR=$1
COMMIT=$2
BUILD_ID="$3_$4"

PACKER_DIR=$BUILD_DIR/packer

$TOOLS_DIR/bin/packer build -force \
  -var "site_dir=$BUILD_DIR/www" \
  -var "commit=$COMMIT" \
  -var "build_id=$BUILD_ID" \
  $PACKER_DIR/packer.json

AMI=`jq -r '.builds[0].artifact_id[-12:]' manifest.json`
echo $AMI
