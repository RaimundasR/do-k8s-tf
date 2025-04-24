#!/bin/bash
set -e

echo "🧨 Phase 1: Destroy all except VPC..."
terraform destroy \
  -target=null_resource.vpc_guard \
  -target=digitalocean_project_resources.assign_cluster_to_project \
  -target=digitalocean_kubernetes_cluster.fra1_single_node \
  -target=digitalocean_project.bka_k8s \
  -var-file=infra.config.json \
  -auto-approve

echo "⏳ Waiting 60 seconds for DO to release VPC resources..."
sleep 60

echo "🚨 Phase 2: Destroy VPC now..."
terraform destroy \
  -target=digitalocean_vpc.custom_vpc \
  -var-file=infra.config.json \
  -auto-approve

