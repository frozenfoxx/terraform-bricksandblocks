variable "ansible_inventory_path" {
  default     = "inventory"
  type        = string
  description = "Path for cloning an Ansible Inventory from a remotely stored Inventory"
  sensitive   = true
}

variable "ansible_rclone_config_inventory_access_key_id" {
  default     = ""
  type        = string
  description = "Configuration access key ID if rclone is used for a remotely stored Inventory"
  sensitive   = true
}

variable "ansible_rclone_config_inventory_account" {
  default     = ""
  type        = string
  description = "Configuration account ID if rclone is used for a remotely stored Inventory"
  sensitive   = true
}

variable "ansible_rclone_config_inventory_acl" {
  default     = "private"
  type        = string
  description = "Configuration ACL if rclone is used for a remotely stored Inventory"
}

variable "ansible_rclone_config_inventory_endpoint" {
  default     = ""
  type        = string
  description = "Configuration endpoint if rclone is used for a remotely stored Inventory"
}

variable "ansible_rclone_config_inventory_env_auth" {
  default     = "true"
  type        = string
  description = "Configuration env_auth if rclone is used for a remotely stored Inventory"
}

variable "ansible_rclone_config_inventory_hard_delete" {
  default     = "true"
  type        = string
  description = "Configuration hard_delete if rclone is used for a remotely stored Inventory"
}

variable "ansible_rclone_config_inventory_key" {
  default     = ""
  type        = string
  description = "Configuration key if rclone is used for a remotely stored Inventory"
  sensitive   = true
}

variable "ansible_rclone_config_inventory_provider" {
  default     = ""
  type        = string
  description = "Configuration provider if rclone is used for a remotely stored Inventory"
}

variable "ansible_rclone_config_inventory_secret_access_key" {
  default     = ""
  type        = string
  description = "Configuration secret access key if rclone is used for a remotely stored Inventory"
  sensitive   = true
}

variable "ansible_rclone_config_inventory_type" {
  default     = ""
  type        = string
  description = "Configuration type if rclone is used for a remotely stored Inventory"
}

variable "ansible_repo" {
  default     = "https://github.com/frozenfoxx/ansible-bricksandblocks.git"
  type        = string
  description = "Repository containing Ansible playbooks"
}

variable "linodedns_domain" {
  default     = "bricksandblocks.net"
  type        = string
  description = "Domain used for Linode DNS"
}

variable "linodedns_subdomain" {
  default     = "*"
  type        = string
  description = "Subdomain used for Linode DNS"
}

variable "linodedns_token" {
  default     = ""
  description = "Token for usage with Linode DNS"
  sensitive   = true
}

variable "livedns_api_key" {
  default     = ""
  type        = string
  description = "API key for usage with LiveDNS"
  sensitive   = true
}

variable "livedns_domain" {
  default     = "bricksandblocks.net"
  type        = string
  description = "Domain used for LiveDNS"
}

variable "livedns_subdomain" {
  default     = "*"
  type        = string
  description = "Subdomain used for LiveDNS"
}

variable "pm_api_url" {
  default     = ""
  type        = string
  description = "URL for Proxmox API"
}

variable "pm_user" {
  default     = ""
  type        = string
  description = "User ID for Proxmox API"
}

variable "pm_pass" {
  default     = ""
  type        = string
  description = "Password for Proxmox API"
  sensitive   = true
}

variable "private_ssh_key" {
  default     = "~/.ssh/id_rsa"
  type        = string
  description = "SSH Private Key"
  sensitive   = true
}

variable "private_backup_ssh_key" {
  default     = "~/.ssh/backup_id_rsa"
  type        = string
  description = "SSH Private Key"
  sensitive   = true
}

variable "public_ssh_key" {
  default     = "~/.ssh/id_rsa.pub"
  type        = string
  description = "SSH Public Key Fingerprint"
}

variable "public_backup_ssh_key" {
  default     = "~/.ssh/backup_id_rsa.pub"
  type        = string
  description = "SSH Public Key Fingerprint"
}

variable "target_node" {
  default     = "host-1"
  type        = string
  description = "Proxmox cluster node to target for deployment"
}