resource "random_password" "backup_password" {
  length  = 16
  special = true
}

resource "proxmox_lxc" "backup" {
  count           = 0
  target_node     = var.target_node
  hostname        = "backup-${sum([count.index, 1])}"
  onboot          = true
  ostemplate      = "images:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  password        = random_password.backup_password.result
  ssh_public_keys = join("", [for key in var.public_ssh_keys : file(key)])
  start           = true
  unprivileged    = true

  cores  = 2
  memory = 2048
  swap   = 1024

  rootfs {
    storage = "pool"
    size    = "20G"
  }

  network {
    name     = "eth0"
    bridge   = "vmbr0"
    ip       = "192.168.2.38/24"
    ip6      = "dhcp"
    gw       = "192.168.2.1"
    firewall = true
  }

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file(var.private_ssh_key)
    host        = split("/", self.network[0].ip)[count.index]
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y"]
  }
}

output "backup_ip" {
  value = one(proxmox_lxc.backup[*].network[0].ip)
}

output "backup_password" {
  value     = random_password.backup_password.result
  sensitive = true
}
