output "aws_instance_private_ip" {
  value = "${aws_instance.instance_default.*.private_ip}"
}
output "aws_instance_public_ip" {
  value = "${aws_instance.instance_default.*.public_ip}"
}