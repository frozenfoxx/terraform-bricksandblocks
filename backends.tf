# Store statefile in Terraform Cloud
terraform {
  cloud {
    organization = "bricksandblocks"

    workspaces {
      name = "terraform-bricksandblocks"
    }
  }
}

# Store statefile locally
# terraform {
#   backend "local" {}
# }
