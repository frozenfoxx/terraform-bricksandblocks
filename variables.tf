variable "ansible_repo" {
  default     = "https://github.com/frozenfoxx/ansible-bricksandblocks.git"
  description = "Repository containing Ansible playbooks"
}

variable "livedns_api_key" {
  default     = ""
  description = "API key for usage with LiveDNS"
}

variable "livedns_domain" {
  default     = "bricksandblocks.net"
  description = "Domain used for LiveDNS"
}

variable "livedns_subdomain" {
  default     = ""
  description = "Subdomain used for LiveDNS"
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
