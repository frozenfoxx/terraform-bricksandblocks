resource "proxmox_vm_qemu" "docker-host-1" {
  os_type     = "cloud-init"
  count       = 2
  clone       = var.template
  name        = "docker-${count.index + 1}"
  target_node = "host-1"
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
          storage = "images"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          asyncio  = "threads"
          iothread = true
          storage  = "local-lvm"
          size     = "100G"
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

resource "proxmox_vm_qemu" "docker-host-2" {
  os_type     = "cloud-init"
  count       = 2
  clone       = var.template
  name        = "docker-${count.index + 3}"
  target_node = "host-2"
  onboot      = true
  agent       = 0
  qemu_os     = "other"
  tags        = "docker"

  cores     = 4
  memory    = 8192
  bios      = "seabios"
  scsihw    = "virtio-scsi-pci"
  ipconfig0 = "ip=192.168.2.${count.index + 26}/24,gw=192.168.2.1"
  sshkeys   = join("", [for key in var.public_ssh_keys : file(key)])

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "images"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          asyncio  = "threads"
          iothread = true
          storage  = "local-lvm"
          size     = "100G"
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
    host        = "192.168.2.${count.index + 26}"
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y"]
  }
}

resource "proxmox_vm_qemu" "docker-host-3" {
  os_type     = "cloud-init"
  count       = 1
  clone       = var.template
  name        = "docker-${count.index + 5}"
  target_node = "host-3"
  onboot      = true
  agent       = 0
  qemu_os     = "other"
  tags        = "docker"

  cores     = 8
  memory    = 16384
  bios      = "seabios"
  scsihw    = "virtio-scsi-pci"
  ipconfig0 = "ip=192.168.2.${count.index + 28}/24,gw=192.168.2.1"
  sshkeys   = join("", [for key in var.public_ssh_keys : file(key)])

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "images"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          asyncio  = "threads"
          iothread = true
          storage  = "local-lvm"
          size     = "100G"
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
    host        = "192.168.2.${count.index + 28}"
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y"]
  }
}
