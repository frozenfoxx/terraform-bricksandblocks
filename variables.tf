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

variable "public_ssh_keys" {
  default     = ["~/.ssh/id_rsa.pub", "~/.ssh/backup_id_rsa.pub"]
  type        = list(string)
  description = "SSH Public Key Fingerprint"
}

variable "target_node" {
  default     = "host-1"
  type        = string
  description = "Proxmox cluster node to target for deployment"
}
