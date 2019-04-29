resource "aws_security_group" "terraform_sg" {
  vpc_id = "${aws_vpc.terraform_vpc.id}"
  name   = "Terraform Security Group"

  # tags = "${merge(map("Name", var.cluster_name, format("kubernetes.io/cluster/%v", var.cluster_name), "owned"), var.tags)}"
}

# Allow outgoing connectivity
resource "aws_security_group_rule" "allow_all_outbound_from_terraform_sg" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.terraform_sg.id}"
}

# Allow SSH connections only from specific CIDR (TODO)
resource "aws_security_group_rule" "allow_ssh_from_cidr" {
  count             = "${length(var.ssh_access_cidr)}"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.ssh_access_cidr[count.index]}"]
  security_group_id = "${aws_security_group.terraform_sg.id}"
}

# Allow Inbound Traffic on Port 80
resource "aws_security_group_rule" "allow_all_http" {
  count             = "${length(var.api_access_cidr)}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.terraform_sg.id}"
}

# Allow Inbound Traffic on Port 443
resource "aws_security_group_rule" "allow_all_https" {
  count             = "${length(var.api_access_cidr)}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.terraform_sg.id}"
}

# Allow the security group members to talk with each other without restrictions
resource "aws_security_group_rule" "allow_terraform_cluster_crosstalk" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.terraform_sg.id}"
  security_group_id        = "${aws_security_group.terraform_sg.id}"
}

# Allow ICMP echo requests
resource "aws_security_group_rule" "allow_api_from_cidr" {
  count             = "${length(var.api_access_cidr)}"
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["${var.api_access_cidr[count.index]}"]
  security_group_id = "${aws_security_group.terraform_sg.id}"
}
