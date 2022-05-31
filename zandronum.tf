resource "random_password" "zandronum_password" {
  length  = 16
  special = true
}

resource "proxmox_lxc" "zandronum" {
  target_node  = var.target_node 
  hostname     = "zandronum"
  ostemplate   = "local:images/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
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
    size    = "10G"
  }

  network {
    name     = "eth0"
    bridge   = "vmbr0"
    ip       = "192.168.2.30"
    ip6      = "dhcp"
    gw       = "192.168.2.1"
    firewall = true
  }
}

output "zandronum_ip" {
  value = proxmox_lxc.zandronum.network[0].ip
}

output "zandronum_password" {
  value     = random_password.zandronum_password.result
  sensitive = true
}
