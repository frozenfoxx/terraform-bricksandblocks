resource "random_password" "plex_password" {
  length  = 16
  special = true
}

resource "proxmox_lxc" "plex" {
  count           = 1
  target_node     = var.target_node
  hostname        = "plex"
  onboot          = true
  ostemplate      = "images:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  password        = random_password.plex_password.result
  ssh_public_keys = join("", [for key in var.public_ssh_keys : file(key)])
  start           = true
  unprivileged    = true
  tags            = "plex"

  cores  = 4
  memory = 2048
  swap   = 1024

  rootfs {
    storage = "pool"
    size    = "50G"
  }

  mountpoint {
    key     = "0"
    slot    = 0
    storage = "/srv/plex/Music"
    volume  = "/srv/plex/Music"
    mp      = "/mnt/Music"
    size    = "0T"
  }

  mountpoint {
    key     = "1"
    slot    = 1
    storage = "/srv/plex/Videos"
    volume  = "/srv/plex/Videos"
    mp      = "/mnt/Videos"
    size    = "0T"
  }

  network {
    name     = "eth0"
    bridge   = "vmbr0"
    ip       = "192.168.2.22/24"
    ip6      = "dhcp"
    gw       = "192.168.2.1"
    firewall = true
  }

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file(var.private_ssh_key)
    host        = split("/", one(proxmox_lxc.plex[*].network[0].ip))[0]
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y"]
  }
}

output "plex_ip" {
  value = one(proxmox_lxc.plex[*].network[0].ip)
}

output "plex_password" {
  value     = random_password.plex_password.result
  sensitive = true
}
