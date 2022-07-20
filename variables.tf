variable "ansible_repo" {
  default     = "https://github.com/frozenfoxx/ansible-bricksandblocks.git"
  description = "Repository containing Ansible playbooks"
}

variable "barotrauma_server_maxplayers" {
  default     = "16"
  description = "Maximum number of players to allow on the server"
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

variable "barotrauma_server_public" {
  default     = "true"
  description = "Whether the server is publicly listed or not"
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
