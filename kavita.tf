resource "random_password" "kavita_password" {
  length  = 16
  special = true
}

resource "proxmox_lxc" "kavita" {
  count           = 1
  target_node     = var.target_node
  hostname        = "kavita"
  onboot          = true
  ostemplate      = "images:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  password        = random_password.kavita_password.result
  ssh_public_keys = join("", [for key in var.public_ssh_keys : file(key)])
  start           = true
  unprivileged    = true
  tags            = "kavita"

  cores  = 2
  memory = 4096
  swap   = 1024

  rootfs {
    storage = "pool"
    size    = "10G"
  }

  mountpoint {
    key     = "0"
    slot    = 0
    storage = "/srv/kavita/Library"
    volume  = "/srv/kavita/Library"
    mp      = "/Library"
    size    = "0T"
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
    host        = split("/", self.network[0].ip)[0]
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y"]
  }
}

output "kavita_ip" {
  value = one(proxmox_lxc.kavita[*].network[0].ip)
}

output "kavita_password" {
  value     = random_password.kavita_password.result
  sensitive = true
}
