# Let's view the IP our EC2 was assigned
output "master_elastic_ip" {
  value = "${aws_eip.terraform_master_ip.public_ip}"
}
