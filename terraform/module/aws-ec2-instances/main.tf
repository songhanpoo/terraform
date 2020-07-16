resource "aws_instance" "instance_default" {

  count                  = "${var.count}"
  ami                    = "${var.aws_ami_id}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${element(var.subnet_id,count.index)}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  iam_instance_profile   = "${var.iam-role}"
  user_data              = "${var.user_data}"
  tags {
    "Name"               = "${var.tags}"
  }

  root_block_device {
    volume_size           = "${var.volume_size}"
    volume_type           = "${var.volume_type}"
    delete_on_termination = "${var.delete_on_termination}"
  }
  ebs_block_device {
    device_name = "${var.device_name}"
    volume_size = "${var.ebs_volume_size}"
    volume_type = "${var.ebs_volume_type}"
    delete_on_termination = "${var.ebs_delete_on_termination}"
  }

}