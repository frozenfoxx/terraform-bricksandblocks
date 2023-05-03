resource "random_password" "serge_password" {
  length  = 16
  special = true
}

resource "proxmox_vm_qemu" "serge" {
  preprovision = true
  os_type      = "ubuntu"
  count        = 1
  target_node  = var.target_node
  name         = "serge"
  onboot       = true
  agent        = 1

  cores        = 8
  memory       = 32768
  iso          = "images:iso/ubuntu-22.04.02-live-server-amd64.iso"
  ipconfig0    = "ip=192.168.2.38/24,gw=192.168.2.1"
  sshkeys      = join("\n", [for key in var.public_ssh_keys : file(key)])

  disk {
    id       = 0
    iothread = 1
    storage  = "pool"
    size     = "50G"
    type     = "scsi"
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
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

  provisioner "local-exec" {
    command = "${path.module}/scripts/ansible_deploy.sh"
    environment = {
      ANSIBLE_DIR = "ansible-serge"
      ANSIBLE_REPO = var.ansible_repo
      INVENTORY_PATH = var.ansible_inventory_path
      RCLONE_CONFIG_INVENTORY_ACCOUNT = var.ansible_rclone_config_inventory_account
      RCLONE_CONFIG_INVENTORY_KEY = var.ansible_rclone_config_inventory_key
      RCLONE_CONFIG_INVENTORY_TYPE = var.ansible_rclone_config_inventory_type
      PLAYBOOK = "serge.yml"
      PRIVATE_SSH_KEY = var.private_ssh_keys[0]
      TARGET = split("/", self.network_interfaces[0].ip_address)[0]
    }
  }
}

output "serge_ip" {
  value = proxmox_vm_qemu.serge[*].network_interfaces[0].ip_address
}

output "serge_password" {
  value     = random_password.serge_password.result
  sensitive = true
}
