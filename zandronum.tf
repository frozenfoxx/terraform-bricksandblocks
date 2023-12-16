resource "random_password" "zandronum_password" {
  length  = 16
  special = true
}

resource "proxmox_lxc" "zandronum" {
  count           = 1
  target_node     = var.target_node
  hostname        = "zandronum"
  onboot          = true
  ostemplate      = "images:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  password        = random_password.zandronum_password.result
  ssh_public_keys = join("", [for key in var.public_ssh_keys : file(key)])
  start           = true
  unprivileged    = true
  tags            = "zandronum"

  cores  = 2
  memory = 1024
  swap   = 1024

  rootfs {
    storage = "pool"
    size    = "10G"
  }

  mountpoint {
    key     = "0"
    slot    = 0
    storage = "/srv/zandronum/wads"
    volume  = "/srv/zandronum/wads"
    mp      = "/wads"
    size    = "0T"
  }

  network {
    name     = "eth0"
    bridge   = "vmbr0"
    ip       = "192.168.2.35/24"
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

output "zandronum_ip" {
  value = one(proxmox_lxc.zandronum[*].network[0].ip)
}

output "zandronum_password" {
  value     = random_password.zandronum_password.result
  sensitive = true
}
