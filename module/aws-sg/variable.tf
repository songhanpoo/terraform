variable "environment" {
   description = "Environment resources belong to"
}
variable "security_groupname" {
  description = "allow incomming HTTP connection"
}
variable "description" {
  description = " description of security group"
}

variable "inbound_cidr_blocks" { type = "map" }
variable "outbound_cidr_blocks" {type = "map"}
variable "outbound_source_security_group" {type = "map"}
variable "inbound_source_security_group" { type = "map"}
variable "tags" {
  type = "map"
}
variable "number_of_ingress_source_security_group_id" {}
variable "number_of_egress_source_security_group_id" {}
variable "vpc_id" {}
