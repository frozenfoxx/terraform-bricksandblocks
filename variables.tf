variable "pm_api_url" {
  default     = ""
  description = "URL for Proxmox API"
}

variable "pm_api_token_id" {
  default     = ""
  description = "Token ID for Proxmox API"
}

variable "pm_api_token_secret" {
  default     = ""
  description = "Token for Proxmox API"
}

variable "target_node" {
  default     = "host-1"
  description = "Proxmox cluster node to target for deployment"
}
