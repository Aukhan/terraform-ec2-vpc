# Create a VPC to launch our instances into.
resource "aws_vpc" "terraform_vpc" {
  cidr_block = "${var.vpc_entire_cidr}"

  #### this 2 true values are for use the internal vpc dns resolution
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "Generated by Terraform - VPC for EC2 deployment"
  }
}

# Create an internet gateway to give our vpc access to the outside world.
resource "aws_internet_gateway" "terraform_gateway" {
  vpc_id = "${aws_vpc.terraform_vpc.id}"

  tags {
    Name = "Generated by Terraform - internet gateway for VPC"
  }
}

# Create a subnet in the VPC
resource "aws_subnet" "terraform_cluster_subnet" {
  vpc_id            = "${aws_vpc.terraform_vpc.id}"
  cidr_block        = "${var.vpc_entire_cidr}"
  availability_zone = "us-east-1a"
}

# Grant the VPC internet access on its main route table.
resource "aws_route_table" "terraform_route_table" {
  vpc_id = "${aws_vpc.terraform_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.terraform_gateway.id}"
  }

  tags {
    Name = "Generated by Terraform - route table for vpc access"
  }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = "${aws_subnet.terraform_cluster_subnet.id}"
  route_table_id = "${aws_route_table.terraform_route_table.id}"
}

# create a an elastic IP for the master
resource "aws_eip" "terraform_master_ip" {
  instance = "${aws_instance.terraform_ec2.id}"
  vpc      = true
}
