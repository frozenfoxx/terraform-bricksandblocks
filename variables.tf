variable "ansible_rclone_configs" {
  default     = ""
  type        = string
  description = "Config YAML for ansible_rclone"
}

variable "ansible_repo" {
  default     = "https://github.com/frozenfoxx/ansible-bricksandblocks.git"
  type        = string
  description = "Repository containing Ansible playbooks"
}

variable "barotrauma_clientperm" {
  default     = ""
  type        = string
  description = "Space delimited, colon interior-delimited list of users with Ranks for Barotrauma (ex. \"Frozen:[steam64]:Admin\")"
}

variable "barotrauma_server_msg" {
  default     = "Welcome to the Church of Foxx Barotrauma server, let Frozen know if you experience issues."
  type        = string
  description = "Message of the day for a Barotrauma server"
}

variable "barotrauma_server_name" {
  default     = "Church of Foxx"
  type        = string
  description = "Name of a Barotrauma server"
}

variable "barotrauma_server_pass" {
  default     = ""
  type        = string
  description = "Password for connecting to a Barotrauma server"
  sensitive   = true
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

variable "rclone_backup_sources" {
  default     = ""
  type        = string
  description = "Colon-separated, space-delimited list of backup sources and types to run (ex. \"someserver-2:barotrauma otherserver-5:library\")"
}

variable "rclone_backup_target" {
  default     = ""
  type        = string
  description = "Target host for backups"
}

variable "target_node" {
  default     = "host-1"
  type        = string
  description = "Proxmox cluster node to target for deployment"
}

variable "zandronum_rcon_pass" {
  default     = ""
  type        = string
  description = "Password for connecting to a Zandronum server with RCON"
  sensitive   = true
}

variable "zandronum_server_pass" {
  default     = ""
  type        = string
  description = "Password for connecting to a Zandronum server"
  sensitive   = true
}
