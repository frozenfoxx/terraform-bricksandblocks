resource "random_password" "docker-1_password" {
  length  = 16
  special = true
}

resource "random_password" "docker-2_password" {
  length  = 16
  special = true
}

resource "proxmox_vm_qemu" "docker-1" {
  os_type     = "cloud-init"
  count       = 1
  clone       = var.template
  name        = "docker-1"
  target_node = var.target_node
  onboot      = true
  agent       = 0
  qemu_os     = "other"
  tags        = "docker"

  cores     = 4
  memory    = 8192
  bios      = "seabios"
  scsihw    = "virtio-scsi-pci"
  ipconfig0 = "ip=192.168.2.24/24,gw=192.168.2.1"
  sshkeys   = join("", [for key in var.public_ssh_keys : file(key)])

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "pool"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          storage = "pool"
          size    = "20G"
        }
      }
    }
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_ssh_key)
    host        = "192.168.2.24"
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y"]
  }
}

resource "proxmox_vm_qemu" "docker-2" {
  os_type     = "cloud-init"
  count       = 1
  clone       = var.template
  name        = "docker-2"
  target_node = var.target_node
  onboot      = true
  agent       = 0
  qemu_os     = "other"
  tags        = "docker"

  cores     = 4
  memory    = 8192
  bios      = "seabios"
  scsihw    = "virtio-scsi-pci"
  ipconfig0 = "ip=192.168.2.25/24,gw=192.168.2.1"
  sshkeys   = join("", [for key in var.public_ssh_keys : file(key)])

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "pool"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          storage = "pool"
          size    = "20G"
        }
      }
    }
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_ssh_key)
    host        = "192.168.2.25"
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y"]
  }
}

output "docker-1_ip" {
  value = "192.168.2.24"
}

output "docker-2_ip" {
  value = "192.168.2.25"
}

output "docker-1_password" {
  value     = random_password.docker-1_password.result
  sensitive = true
}

output "docker-2_password" {
  value     = random_password.docker-1_password.result
  sensitive = true
}