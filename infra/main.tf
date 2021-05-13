
module "ec2_keypair" {
  source    = "../module/aws-keypair"
  algorithm = "${var.algorithm}"
  rsa_bits  = "${var.rsa_bits}"
  key_name  = "${var.key_name}"
}

module "aws_sg" {
  source = "../module/aws-sg"
  environment        = "testing"
  description        = "receive connection form deploy server"
  security_groupname = "sg_test"
  vpc_id             = "${var.vpc_id}"
  inbound_cidr_blocks      = {
    "0" = ["0.0.0.0/0", "0", "0", "-1"]
    "1" = ["${chomp(data.http.workstation_ip.body)}/32", "22", "22", "tcp" ]
  }
  outbound_cidr_blocks     = {
    "0" = ["0.0.0.0/0", "0", "0", "-1"]
  }
  ###source security group id###
  number_of_ingress_source_security_group_id = 0
  inbound_source_security_group = {}

  number_of_egress_source_security_group_id = 0
  outbound_source_security_group = {}
  tags     = {
    "Name" = "sg-test"
  }
}

module "ec2_instance" {
  source = "../module/aws-ec2-instances"
  count                  = "${var.count}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${var.subnet_id}"
  key_name               = "${module.ec2_keypair.aws_keyname}"
  vpc_security_group_ids = ["${module.aws_sg.security_group_id}"]
  aws_ami_id             = "${data.aws_ami.ubuntu_1804.image_id}"
  environment            = "${var.environment}"
  tags                   = "${var.tags}"
  iam-role               = "${var.iam-role}"
  user_data              = "${var.user_data}"
  #root volume
  volume_type = "${var.volume_type}"
  volume_size = "${var.volume_size}"
  delete_on_termination = true
  #ebs volume
  ebs_delete_on_termination = true
  ebs_volume_size = "${var.ebs_volume_size}"
  ebs_volume_type = "${var.ebs_volume_type}"
  device_name     = "${var.device_name}"
}