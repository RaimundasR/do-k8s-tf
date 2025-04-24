variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive   = true
}

variable "region" {}
variable "vpc_name" {}
variable "vpc_cidr" {}
variable "cluster_name" {}
variable "cluster_version" {}
variable "node_pool_name" {}
variable "node_size" {}
variable "node_count" {
  type = number
}
variable "project_name" {}
variable "project_description" {}
variable "project_purpose" {}
variable "project_environment" {}

