variable "ansible_repo" {
  default     = "https://github.com/frozenfoxx/ansible-bricksandblocks.git"
  description = "Repository containing Ansible playbooks"
}

variable "barotrauma_clientperm" {
  default     = ""
  description = "Space delimited, colon interior-delimited list of users with Ranks for Barotrauma (ex. \"Frozen:[steam64]:Admin\")"
}

variable "barotrauma_server_msg" {
  default     = "Welcome to the Church of Foxx Barotrauma server, let Frozen know if you experience issues."
  description = "Message of the day for a Barotrauma server"
}

variable "barotrauma_server_name" {
  default     = "Church of Foxx"
  description = "Name of a Barotrauma server"
}

variable "barotrauma_server_pass" {
  default     = ""
  description = "Password for connecting to a Barotrauma server"
  sensitive   = true
}

variable "linodedns_domain" {
  default     = "bricksandblocks.net"
  description = "Domain used for Linode DNS"
}

variable "linodedns_subdomain" {
  default     = "*"
  description = "Subdomain used for Linode DNS"
}

variable "linodedns_token" {
  default     = ""
  description = "Token for usage with Linode DNS"
  sensitive   = true
}

variable "livedns_api_key" {
  default     = ""
  description = "API key for usage with LiveDNS"
  sensitive   = true
}

variable "livedns_domain" {
  default     = "bricksandblocks.net"
  description = "Domain used for LiveDNS"
}

variable "livedns_subdomain" {
  default     = "*"
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
  sensitive   = true
}

variable "private_ssh_key" {
  default     = "~/.ssh/id_rsa"
  description = "SSH Private Key"
  sensitive   = true
}

variable "public_ssh_key" {
  default     = "~/.ssh/id_rsa.pub"
  description = "SSH Public Key Fingerprint"
}

variable "target_node" {
  default     = "host-1"
  description = "Proxmox cluster node to target for deployment"
}

variable "zandronum_rcon_pass" {
  default     = ""
  description = "Password for connecting to a Zandronum server with RCON"
  sensitive   = true
}

variable "zandronum_server_pass" {
  default     = ""
  description = "Password for connecting to a Zandronum server"
  sensitive   = true
}
