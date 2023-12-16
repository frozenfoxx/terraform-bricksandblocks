# terraform-bricksandblocks

TerraForm code for deploying BricksAndBlocks infrastructure.

# Requirements

* [git](http://git-scm.com)
* [rclone](https://rclone.org)
* [Terraform Cloud](https://cloud.hashicorp.com/products/terraform)
* [Task](https://taskfile.dev)

# Configuration

* Make a copy of `env.dist` called `.env`
* Fill in appropriate values for `.env`
* Make a copy of `main.auto.tfvars.example` called `main.auto.tfvars`
* Fill in appropriate values for `main.auto.tfvars`
* Log into Terraform Cloud with `terraform login`
* Add submodule for taskfiles and run setup task

```
git submodule add https://github.com/frozenfoxx/taskfiles.git .taskfiles
task setup
```

# Usage

- **reinitialize Terraform**: `rm -rf .terraform && terraform init`
- **redeploy a resource**: `terraform destroy -target=[resource provider].[resource] --auto-approve && terraform apply --auto-approve`
