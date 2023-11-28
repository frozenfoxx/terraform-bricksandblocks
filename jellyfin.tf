resource "random_password" "jellyfin_password" {
  length  = 16
  special = true
}

resource "proxmox_lxc" "jellyfin" {
  count           = 1
  target_node     = var.target_node
  hostname        = "jellyfin"
  onboot          = true
  ostemplate      = "images:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  password        = random_password.jellyfin_password.result
  ssh_public_keys = join("", [for key in var.public_ssh_keys : file(key)])
  start           = true
  unprivileged    = true
  tags            = "jellyfin"

  cores           = 2
  memory          = 2048
  swap            = 1024

  rootfs {
    storage = "pool"
    size    = "20G"
  }

  mountpoint {
    key     = "0"
    slot    = 0
    storage = "/srv/jellyfin/Music"
    volume  = "/srv/jellyfin/Music"
    mp      = "/mnt/Music"
    size    = "0T"
  }

  mountpoint {
    key     = "1"
    slot    = 1
    storage = "/srv/jellyfin/Videos"
    volume  = "/srv/jellyfin/Videos"
    mp      = "/mnt/Videos"
    size    = "0T"
  }

  network {
    name     = "eth0"
    bridge   = "vmbr0"
    ip       = "192.168.2.27/24"
    ip6      = "dhcp"
    gw       = "192.168.2.1"
    firewall = true
  }

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file(var.private_ssh_key)
    host        = split("/", one(proxmox_lxc.jellyfin[*].network[0].ip))[0]
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y"]
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/ansible_deploy.sh"
    environment = {
      ANSIBLE_DIR = "ansible-jellyfin"
      ANSIBLE_REPO = var.ansible_repo
      INVENTORY_PATH = var.ansible_inventory_path
      RCLONE_CONFIG_INVENTORY_ACCOUNT = var.ansible_rclone_config_inventory_account
      RCLONE_CONFIG_INVENTORY_KEY = var.ansible_rclone_config_inventory_key
      RCLONE_CONFIG_INVENTORY_TYPE = var.ansible_rclone_config_inventory_type
      PLAYBOOK = "jellyfin.yml"
      PRIVATE_SSH_KEY = var.private_ssh_key
      TARGET = split("/", one(proxmox_lxc.jellyfin[*].network[0].ip))[0]
    }
  }
}

output "jellyfin_ip" {
  value = one(proxmox_lxc.jellyfin[*].network[0].ip)
}

output "jellyfin_password" {
  value     = random_password.jellyfin_password.result
  sensitive = true
}
