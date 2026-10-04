resource "proxmox_download_file" "debian_cloud_image" {
  content_type = "import"
  datastore_id = var.image_datastore_id
  node_name    = var.target_node
  url          = "https://cloud.debian.org/images/cloud/trixie/latest/debian-13-genericcloud-amd64.qcow2"
  file_name    = "debian-13-trixie.qcow2"
}

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
    file_id      = proxmox_download_file.debian_cloud_image.id
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
        address = "dhcp"
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
