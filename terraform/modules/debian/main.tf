resource "proxmox_virtual_environment_file" "vendor_data" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.target_node

  source_raw {
    data      = file("${path.module}/cloud-init/vendor-data.yaml")
    file_name = "vendor-data.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "debian" {
  name      = var.vm_name
  node_name = var.target_node
  vm_id     = var.vm_id

  agent {
    enabled = true
    timeout = "2m"
  }

  cpu {
    cores = 2
    type  = "host"
  }

  memory {
    dedicated = 4096
  }

  disk {
    datastore_id = var.datastore_id
    file_id      = var.cloud_image_id
    interface    = "scsi0"
    size         = 20
  }

  network_device {
    bridge = "vmbr0"
  }

  initialization {
    datastore_id = var.datastore_id

    ip_config {
      ipv4 {
        address = var.ip_address
        gateway = "192.168.0.1"
      }
    }

    user_account {
      username = var.ci_user
      password = var.ci_password
      keys     = [var.ci_ssh_key]
    }

    vendor_data_file_id = proxmox_virtual_environment_file.vendor_data.id
  }

  operating_system {
    type = "l26"
  }
}
