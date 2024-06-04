resource "random_password" "heimdall_password" {
  length  = 16
  special = true
}

resource "proxmox_vm_qemu" "heimdall" {
  os_type     = "cloud-init"
  count       = 1
  clone       = "ubuntu-2304"
  name        = "heimdall"
  target_node = var.target_node
  onboot      = true
  agent       = 0
  qemu_os     = "other"
  tags        = "heimdall"

  cores     = 2
  memory    = 4096
  bios      = "seabios"
  scsihw    = "virtio-scsi-pci"
  ipconfig0 = "ip=192.168.2.26/24,gw=192.168.2.1"
  sshkeys   = join("", [for key in var.public_ssh_keys : file(key)])

  disks {
    scsi {
      scsi1 {
        cloudinit {
          storage = "pool"
        }
      }
      scsi2 {
        disk {
          storage = "pool"
          size    = "10G"
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
    host        = "192.168.2.26"
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y"]
  }
}

output "heimdall_ip" {
  value = "192.168.2.26"
}

output "heimdall_password" {
  value     = random_password.heimdall_password.result
  sensitive = true
}
