resource "proxmox_vm_qemu" "cluster" {
  os_type     = "cloud-init"
  count       = 0
  clone       = var.template
  name        = "cluster-${count.index + 1}"
  target_node = var.target_node
  onboot      = true
  agent       = 0
  qemu_os     = "other"
  tags        = "rke2_scheduler"

  cores     = 2
  memory    = 2048
  bios      = "seabios"
  scsihw    = "virtio-scsi-pci"
  ipconfig0 = "ip=192.168.2.${count.index + 40}/24,gw=192.168.2.1"
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
    host        = "192.168.2.${count.index + 40}"
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y"]
  }
}