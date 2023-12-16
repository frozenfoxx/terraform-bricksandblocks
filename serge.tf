resource "random_password" "serge_password" {
  length  = 16
  special = true
}

resource "proxmox_vm_qemu" "serge" {
  os_type      = "cloud-init"
  count        = 0
  clone        = var.template
  name         = "serge"
  target_node  = var.target_node
  onboot       = true
  agent        = 0
  qemu_os      = "other"
  tags         = "serge"

  cores        = 8
  memory       = 32768
  bios         = "seabios"
  scsihw       = "virtio-scsi-pci"
  hotplug      = "network,disk,usb"
  ipconfig0    = "ip=192.168.2.38/24,gw=192.168.2.1"
  sshkeys      = join("", [for key in var.public_ssh_keys : file(key)])

  disk {
    type     = "scsi"
    #FIXME Required due to this error: https://github.com/Telmate/terraform-provider-proxmox/issues/460
    iothread = 0
    storage  = "pool"
    size     = "50G"
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_ssh_key)
    host        = "192.168.2.38"
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y"]
  }
}

output "serge_ip" {
  value = "192.168.2.38"
}

output "serge_password" {
  value     = random_password.serge_password.result
  sensitive = true
}
