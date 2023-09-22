resource "random_password" "cluster-1_password" {
  length  = 16
  special = true
}

resource "proxmox_vm_qemu" "cluster-1" {
  os_type      = "cloud-init"
  count        = 0
  clone        = var.template
  name         = "cluster-1"
  target_node  = var.target_node
  onboot       = true
  agent        = 0
  qemu_os      = "other"

  cores        = 4
  memory       = 4096
  bios         = "seabios"
  scsihw       = "virtio-scsi-pci"
  ipconfig0    = "ip=192.168.2.25/24,gw=192.168.2.1"
  sshkeys      = join("", [for key in var.public_ssh_keys : file(key)])

  disk {
    type     = "scsi"
    #FIXME Required due to this error: https://github.com/Telmate/terraform-provider-proxmox/issues/460
    iothread = 0
    storage  = "pool"
    size     = "20G"
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

  provisioner "local-exec" {
    command = "${path.module}/scripts/ansible_deploy.sh"
    environment = {
      ANSIBLE_DIR = "ansible-cluster-1"
      ANSIBLE_REPO = var.ansible_repo
      INVENTORY_PATH = var.ansible_inventory_path
      RCLONE_CONFIG_INVENTORY_ACCOUNT = var.ansible_rclone_config_inventory_account
      RCLONE_CONFIG_INVENTORY_KEY = var.ansible_rclone_config_inventory_key
      RCLONE_CONFIG_INVENTORY_TYPE = var.ansible_rclone_config_inventory_type
      PLAYBOOK = "cluster-scheduler.yml"
      PRIVATE_SSH_KEY = var.private_ssh_key
      SSH_USER = "ubuntu"
      TARGET = "192.168.2.25"
    }
  }
}

output "cluster-1_ip" {
  value = "192.168.2.25"
}

output "cluster-1_password" {
  value     = random_password.cluster-1_password.result
  sensitive = true
}
