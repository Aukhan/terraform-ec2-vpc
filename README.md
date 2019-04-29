Example to create an AWS VPC and one subnet in that VPC with one EC2. Creates a security group for this infrastructure and rules to allow SSH and HTTP in bound only. It expects that you already have a key generated in AWS and will ask for that key pair's name as a variable.

#### Credentials
- Expects a file named aws.credentials to be placed at the root
- The contents of the file should look like
```sh
[default]
aws_access_key_id=<access_key>
aws_secret_access_key=<secret_key>
```

#### Setup
Change any names if you have to and then run
```sh
terraform plan
```
If all looks good
```sh
terraform apply
```

### Teardown
```sh
terraform destroy
```
