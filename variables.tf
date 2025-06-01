variable "cluster_name" {}
variable "region" {}
variable "vpc_cidr_block" {}
variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "azs" {
  type = list(string)
}
variable "desired_capacity" {}
variable "min_size" {}
variable "max_size" {}
variable "instance_type" {}
variable "tags" {
  type = map(string)
}
