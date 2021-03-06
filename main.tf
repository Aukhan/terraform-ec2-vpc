provider "aws" {
  region = "${var.aws_region}"

  shared_credentials_file = "./aws.credentials"
}

resource "aws_instance" "terraform_ec2" {
  instance_type = "${var.instance_type}"

  ami = "${var.aws_ami}"

  key_name = "${var.key_name}"

  subnet_id = "${aws_subnet.terraform_cluster_subnet.id}"

  # associate_public_ip_address = false

  vpc_security_group_ids = [
    "${aws_security_group.terraform_sg.id}",
  ]
  user_data = "${file("provision-ec2.sh")}"
  tags {
    Name = "Generated by Terraform - EC2"
  }
  root_block_device {
    volume_type           = "gp2"
    volume_size           = "20"
    delete_on_termination = true
  }
}
