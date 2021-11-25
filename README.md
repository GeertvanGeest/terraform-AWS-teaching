These are [terraform](https://www.terraform.io/) scripts for deploying an EC2 instance for teaching. By default, it launches the [Ubuntu deep learning base AMI](https://aws.amazon.com/marketplace/pp/prodview-dxk3xpeg6znhm) which has docker pre-installed. To deploy docker containers on the machine, have a look at [https://github.com/GeertvanGeest/AWS-docker](https://github.com/GeertvanGeest/AWS-docker). 

Before you start, make sure you have `aws cli` installed and configured. After that, have a look at `terraform.tfvars`. Here you will find variables that you need to change. Once you have adjusted this file, you can run the terraform script by:

```sh
terraform init # only once
terraform plan
terraform apply
```

If you want to destroy all rescources run:

```sh
terraform destroy
```
