variable "ansible_repo" {
  default     = "https://github.com/frozenfoxx/ansible-bricksandblocks.git"
  description = "Repository containing Ansible playbooks"
}

variable "pm_api_url" {
  default     = ""
  description = "URL for Proxmox API"
}

variable "pm_user" {
  default     = ""
  description = "User ID for Proxmox API"
}

variable "pm_pass" {
  default     = ""
  description = "Password for Proxmox API"
}

variable "private_ssh_key" {
  default     = "~/.ssh/id_rsa"
  description = "SSH Private Key"
}

variable "public_ssh_key" {
  default     = "~/.ssh/id_rsa.pub"
  description = "SSH Public Key Fingerprint"
}

variable "target_node" {
  default     = "host-1"
  description = "Proxmox cluster node to target for deployment"
}
