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

variable "target_node" {
  default     = "host-1"
  description = "Proxmox cluster node to target for deployment"
}
