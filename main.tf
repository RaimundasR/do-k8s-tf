# Create a new project
resource "digitalocean_project" "bka_k8s" {
  name        = "bka-k8s"
  description = "Project for BKA Kubernetes cluster"
  purpose     = "Web Application Hosting"
  environment = "Development"
}

# Your VPC
data "digitalocean_vpc" "fra1" {
  name = "default-fra1"
}

# Kubernetes cluster
resource "digitalocean_kubernetes_cluster" "fra1_single_node" {
  name    = "do-bka-single-node-cluster"
  region  = "fra1"
  version = "1.32.2-do.0"

  node_pool {
    name       = "default-pool"
    size       = "s-2vcpu-4gb"
    node_count = 1
  }

  vpc_uuid = data.digitalocean_vpc.fra1.id
}

# Assign the cluster to the new project
resource "digitalocean_project_resources" "assign_cluster_to_project" {
  project = digitalocean_project.bka_k8s.id
  resources = [
    digitalocean_kubernetes_cluster.fra1_single_node.urn
  ]
}

