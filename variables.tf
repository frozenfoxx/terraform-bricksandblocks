variable "pm_url" {
  default     = "https://proxmox:8006"
  type        = string
  description = "URL for Proxmox"
}

variable "pm_api_url" {
  default     = "https://proxmox:8006/api/json"
  type        = string
  description = "URL for Proxmox API"
}

variable "pm_user" {
  default     = "terraform@pve"
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
  default     = "~/.ssh/id_ed25519"
  type        = string
  description = "SSH Private Key"
  sensitive   = true
}

variable "root_dir" {
  default     = "."
  type        = string
  description = "Path to the root of the directory within the filesystem"
}

variable "public_ssh_keys" {
  default     = ["~/.ssh/id_ed25519.pub"]
  type        = list(string)
  description = "SSH Public Key Fingerprint"
}

variable "target_node" {
  default     = "host-1"
  type        = string
  description = "Proxmox cluster node to target for deployment"
}

variable "template" {
  default     = "ubuntu-2304"
  type        = string
  description = "Template to clone from"
}