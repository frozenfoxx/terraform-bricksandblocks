resource "random_password" "photos_password" {
  length  = 16
  special = true
}

resource "proxmox_lxc" "photos" {
  count           = 1
  target_node     = var.target_node
  hostname        = "photos"
  ostemplate      = "images:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  password        = random_password.photos_password.result
  ssh_public_keys = file(var.public_ssh_key)
  start           = true
  unprivileged    = true

  cores           = 2
  memory          = 4096
  swap            = 1024

  rootfs {
    storage = "images"
    size    = "20G"
  }

  mountpoint {
    key     = "0"
    slot    = 0
    storage = "/srv/photos/Pictures"
    volume  = "/srv/photos/Pictures"
    mp      = "/mnt"
    size    = "0G"
  }

  network {
    name     = "eth0"
    bridge   = "vmbr0"
    ip       = "192.168.2.28/24"
    ip6      = "dhcp"
    gw       = "192.168.2.1"
    firewall = true
  }

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file(var.private_ssh_key)
    host        = split("/", one(proxmox_lxc.photos[*].network[0].ip))[0]
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y"]
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/ansible_deploy.sh"
    environment = {
      PLAYBOOK = "photostructure.yml"
      PRIVATE_SSH_KEY = var.private_ssh_key
      TARGET = split("/", one(proxmox_lxc.photos[*].network[0].ip))[0]
    }
  }
}

output "photos_ip" {
  value = one(proxmox_lxc.photos[*].network[0].ip)
}

output "photos_password" {
  value     = random_password.photos_password.result
  sensitive = true
}
