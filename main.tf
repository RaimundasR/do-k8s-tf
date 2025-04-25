resource "digitalocean_vpc" "custom_vpc" {
  name     = var.vpc_name
  region   = var.region
  ip_range = var.vpc_cidr
}

resource "digitalocean_project" "bka_k8s" {
  name        = var.project_name
  description = var.project_description
  purpose     = var.project_purpose
  environment = var.project_environment
}

resource "digitalocean_kubernetes_cluster" "single_node" {
  name    = var.cluster_name
  region  = var.region
  version = var.cluster_version

  node_pool {
    name       = var.node_pool_name
    size       = var.node_size
    node_count = var.node_count
  }

  vpc_uuid = digitalocean_vpc.custom_vpc.id

  depends_on = [digitalocean_vpc.custom_vpc]
}

resource "digitalocean_project_resources" "assign_cluster_to_project" {
  project = digitalocean_project.bka_k8s.id
  resources = [
    digitalocean_kubernetes_cluster.single_node.urn
  ]

  depends_on = [
    digitalocean_kubernetes_cluster.single_node,
    digitalocean_project.bka_k8s
  ]
}

resource "null_resource" "vpc_guard" {
  depends_on = [digitalocean_kubernetes_cluster.single_node]
}

