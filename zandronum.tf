resource "random_password" "zandronum_password" {
  length  = 16
  special = true
}

resource "proxmox_lxc" "zandronum" {
  count        = 0
  target_node  = var.target_node 
  hostname     = "zandronum"
  ostemplate   = "images:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  password     = random_password.zandronum_password.result
  unprivileged = true

  cores        = 2
  memory       = 1024
  swap         = 1024

  rootfs {
    storage = "images"
    size    = "10G"
  }

  mountpoint {
    key     = "0"
    slot    = 0
    storage = "/srv/zandronum/wads"
    volume  = "/srv/zandronum/wads"
    mp      = "/wads"
    size    = "0G"
  }

  network {
    name     = "eth0"
    bridge   = "vmbr0"
    ip       = "192.168.2.30/24"
    ip6      = "dhcp"
    gw       = "192.168.2.1"
    firewall = true
  }

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file(var.private_ssh_key)
    host        = split("/", one(proxmox_lxc.zandronum[*].network[0].ip))[0]
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y"]
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/ansible_deploy.sh"
    environment = {
      LIVEDNS_API_KEY = var.livedns_api_key
      LIVEDNS_DOMAIN = var.livedns_domain
      LIVEDNS_SUBDOMAIN = "zandronum"
      PLAYBOOK = "zandronum.yml"
      PRIVATE_SSH_KEY = var.private_ssh_key
      TARGET = split("/", one(proxmox_lxc.zandronum[*].network[0].ip))[0]
      ZANDRONUM_RCON_PASS = var.zandronum_rcon_pass
      ZANDRONUM_SERVER_PASS = var.zandronum_server_pass
    }
  }
}

output "zandronum_ip" {
  value = one(proxmox_lxc.zandronum[*].network[0].ip)
}

output "zandronum_password" {
  value     = random_password.zandronum_password.result
  sensitive = true
}
