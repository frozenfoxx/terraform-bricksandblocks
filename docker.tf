resource "proxmox_vm_qemu" "docker" {
  os_type     = "cloud-init"
  count       = 3
  clone       = var.template
  name        = "docker-${count.index + 1}"
  target_node = var.target_node
  onboot      = true
  agent       = 0
  qemu_os     = "other"
  tags        = "docker"

  cores     = 4
  memory    = 8192
  bios      = "seabios"
  scsihw    = "virtio-scsi-pci"
  ipconfig0 = "ip=192.168.2.${count.index + 24}/24,gw=192.168.2.1"
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
          size    = "100G"
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
    host        = "192.168.2.${count.index + 24}"
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y"]
  }
}