#!/bin/bash
set -e

echo "🔧 Applying Terraform with config from infra.config.json"
terraform init
terraform apply -var-file=infra.config.json "$@"

