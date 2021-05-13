region = "ap-southeast-1"
##ec2##
count         = "1"
instance_type = "t3.small"
subnet_id     = ["subnet-0c67999ceb48692e6"]
key_name      = "your-keypair"
region        = "ap-southeast-1"
environment   = "testing"
iam-role      = ""
user_data     = ""
tags          = "test-ec2"
#root volume
volume_type               = "gp2"
volume_size               = "80"
delete_on_termination     = "true"
#ebs volume
ebs_volume_type           = "gp2"
ebs_delete_on_termination = "true"
ebs_volume_size           = "60"
device_name               = "/dev/sdb"

#security group section
vpc_id        = "vpc-04bad2eef5825819d"
##keypair##
algorithm = "RSA"
rsa_bits  = "4096"
