# terraform-bricksandblocks

TerraForm code for deploying BricksAndBlocks infrastructure.

# Requirements

* [Terraform Cloud](https://cloud.hashicorp.com/products/terraform)
* [Ansible](https://ansible.com)
* [Ansible Galaxy](https://galaxy.ansible.com)
* [git](http://git-scm.com)
* [rclone](https://rclone.org)

# Configuration

* Log into Terraform Cloud with `terraform login`
* Make a copy of `env.dist` called `.env`
* Fill in appropriate values for `.env`
* Make a copy of `main.auto.tfvars.example` called `main.auto.tfvars`
* Fill in appropriate values for `main.auto.tfvars`

# Usage

- **reinitialize Terraform**: `rm -rf .terraform && terraform init`
- **redeploy a resource**: `terraform destroy -target=[resource provider].[resource] --auto-approve && terraform apply --auto-approve`
