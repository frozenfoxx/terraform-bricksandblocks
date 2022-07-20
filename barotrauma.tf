resource "random_password" "barotrauma_password" {
  length  = 16
  special = true
}

resource "proxmox_lxc" "barotrauma" {
  count           = 1
  target_node     = var.target_node
  hostname        = "barotrauma"
  ostemplate      = "images:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  password        = random_password.barotrauma_password.result
  ssh_public_keys = file(var.public_ssh_key)
  start           = true
  unprivileged    = true

  cores           = 2
  memory          = 2048
  swap            = 2048

  rootfs {
    storage = "images"
    size    = "10G"
  }

  mountpoint {
    key     = "0"
    slot    = 0
    storage = "/srv/barotrauma/Multiplayer"
    volume  = "/srv/barotrauma/Multiplayer"
    mp      = "/data/Multiplayer"
    size    = "0G"
  }

  network {
    name     = "eth0"
    bridge   = "vmbr0"
    ip       = "192.168.2.32/24"
    ip6      = "dhcp"
    gw       = "192.168.2.1"
    firewall = true
  }

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file(var.private_ssh_key)
    host        = split("/", one(proxmox_lxc.barotrauma[*].network[0].ip))[0]
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y"]
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/ansible_deploy.sh"
    environment = {
      BAROTRAUMA_SERVER_MAXPLAYERS = var.barotrauma_server_maxplayers
      BAROTRAUMA_SERVER_MSG = var.barotrauma_server_msg
      BAROTRAUMA_SERVER_NAME = var.barotrauma_server_name
      BAROTRAUMA_SERVER_PASS = var.barotrauma_server_pass
      BAROTRAUMA_SERVER_PUBLIC = var.barotrauma_server_public
      LIVEDNS_API_KEY = var.livedns_api_key
      LIVEDNS_DOMAIN = var.livedns_domain
      LIVEDNS_SUBDOMAIN = "barotrauma"
      PLAYBOOK = "barotrauma.yml"
      PRIVATE_SSH_KEY = var.private_ssh_key
      TARGET = split("/", one(proxmox_lxc.barotrauma[*].network[0].ip))[0]
    }
  }
}

output "barotrauma_ip" {
  value = one(proxmox_lxc.barotrauma[*].network[0].ip)
}

output "barotrauma_password" {
  value     = random_password.barotrauma_password.result
  sensitive = true
}
