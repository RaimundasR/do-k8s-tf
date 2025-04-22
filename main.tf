data "digitalocean_vpc" "fra1" {
  name = "default-fra1"
}

resource "digitalocean_kubernetes_cluster" "fra1_single_node" {
  name    = "fra1-single-node"
  region  = "fra1"
  version = "1.32.2-do.0"

  node_pool {
    name       = "default-pool"
    size       = "s-2vcpu-4gb"
    node_count = 1
  }

  vpc_uuid = data.digitalocean_vpc.fra1.id
}

