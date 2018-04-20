#!/bin/bash
set -e

BUILD_DIR=$1
COMMIT=$2
BUILD_ID="$3#$4"

PACKER_DIR=$BUILD_DIR/packer

packer.io build -force \
  -var "site_dir=$BUILD_DIR/www" \
  -var "commit=$COMMIT" \
  -var "build_id=$BUILD_ID" \
  $PACKER_DIR/packer.json

#AMI=$(egrep "(eu|us|ap|sa)-(west|central|east|northeast|southeast)-(1|2|3): ami-" /tmp/packer.out | sed 's/.*ami-\([0-9a-f]*\).*/ami-\1/g')
AMI=`jq -r '.builds[0].artifact_id[-12:]' manifest.json`
echo $AMI
