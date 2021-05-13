variable "region" {}
##ec2##
variable "instance_type" {
  description = "instance default for testing"
}
variable "environment" {
  description = "environment resource belong to"
}
variable "subnet_id" {
  description = "ID of the subnet where instance should be launch"
  type = "list"
}
variable "key_name" {}
variable "count" {}
variable "tags" {}
variable "iam-role" {}
variable "user_data" {}
#root volume
variable "volume_size" {}
variable "volume_type" {}
variable "delete_on_termination" {}
#ebs volume
variable "device_name" {}
variable "ebs_volume_size" {}
variable "ebs_volume_type" {}
variable "ebs_delete_on_termination" {}
##keypair##
variable "algorithm" {}
variable "rsa_bits" {}

##sg##
variable "vpc_id" {}