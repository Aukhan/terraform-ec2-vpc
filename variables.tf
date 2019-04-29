variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "vpc_entire_cidr" {
  default     = "10.0.0.0/16"
  description = "Entire CIDR range for entire VPC"
}

variable "allowed_cidr_blocks" {
  default     = ["0.0.0.0/0"]
  type        = "list"
  description = "Allowed CIDR blocks"
}

# ubuntu Server 18.04 LTS
variable "aws_ami" {
  default = "ami-0a313d6098716f372"
}

variable "availability_zones" {
  default     = "us-east-1a,us-east-1b,us-east-1c,us-east-1d,us-east-1e"
  description = "List of availability zones"
}

variable "key_name" {
  description = "The name of the key to be provided externally"
}

variable "ssh_access_cidr" {
  description = "List of CIDRs from which SSH access is allowed"
  type        = "list"

  default = [
    "0.0.0.0/0",
  ]
}

variable "api_access_cidr" {
  description = "List of CIDRs from which API access is allowed"
  type        = "list"

  default = [
    "0.0.0.0/0",
  ]
}

variable "instance_type" {
  default     = "t2.micro"
  description = "AWS instance type"
}
