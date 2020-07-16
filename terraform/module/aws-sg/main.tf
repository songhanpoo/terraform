resource "aws_security_group" "security_group_default" {

  name        = "${var.security_groupname}"
  vpc_id      = "${var.vpc_id}"
  description = "${var.description}"
  tags        = "${var.tags}"
  lifecycle {create_before_destroy = true}
  revoke_rules_on_delete = true
}
resource "aws_security_group_rule" "ingress_rule_cidr" {
  count             = "${length(var.inbound_cidr_blocks)}"
  type              = "ingress"
  cidr_blocks       = ["${element(var.inbound_cidr_blocks[count.index],0 )}"]
  from_port         = "${element(var.inbound_cidr_blocks[count.index],1 )}"
  to_port           = "${element(var.inbound_cidr_blocks[count.index],2 )}"
  protocol          = "${element(var.inbound_cidr_blocks[count.index],3 )}"
  security_group_id = "${aws_security_group.security_group_default.id}"

}
resource "aws_security_group_rule" "ingress_rule_source_security_group_id" {
  count             = "${var.number_of_ingress_source_security_group_id}"
  type              = "ingress"
  source_security_group_id = "${element(var.inbound_source_security_group[count.index],0 )}"
  from_port         = "${element(var.inbound_source_security_group[count.index],1 )}"
  to_port           = "${element(var.inbound_source_security_group[count.index],2 )}"
  protocol          = "${element(var.inbound_source_security_group[count.index],3 )}"
  security_group_id = "${aws_security_group.security_group_default.id}"
}
resource "aws_security_group_rule" "egress_rule_cidr" {
  count             = "${length(var.outbound_cidr_blocks)}"
  type              = "egress"
  cidr_blocks       = ["${element(var.outbound_cidr_blocks[count.index],0 )}"]
  from_port         = "${element(var.outbound_cidr_blocks[count.index],1 )}"
  to_port           = "${element(var.outbound_cidr_blocks[count.index],2 )}"
  protocol          = "${element(var.outbound_cidr_blocks[count.index],3 )}"
  security_group_id = "${aws_security_group.security_group_default.id}"
}
resource "aws_security_group_rule" "egress_rule_source_security_group_id" {
  count             = "${var.number_of_egress_source_security_group_id}"
  type              = "egress"
  source_security_group_id       = "${element(var.outbound_source_security_group[count.index],0 )}"
  from_port         = "${element(var.outbound_source_security_group[count.index],1 )}"
  to_port           = "${element(var.outbound_source_security_group[count.index],2 )}"
  protocol          = "${element(var.outbound_source_security_group[count.index],3 )}"
  security_group_id = "${aws_security_group.security_group_default.id}"
}