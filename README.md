# terraform-bricksandblocks

TerraForm code for deploying BricksAndBlocks infrastructure.

# Requirements

* [Terraform Cloud](https://cloud.hashicorp.com/products/terraform) account
* `terraform login` successfully run
* Filled out variables in `main.auto.tfvars`
* Local, activated installation of [Ansible](https://ansible.com)
* [rclone](https://rclone.org)

# Usage

``` code
$ rm -rf .terraform
$ terraform init
$ bash -c 'terraform [command]'
```
