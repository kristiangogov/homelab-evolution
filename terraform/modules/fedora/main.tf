resource "proxmox_download_file" "fedora_cloud_image" {
  content_type = "import"
  datastore_id = var.image_datastore_id
  node_name    = var.target_node
  ## TODO! fix image source
  ## Debian: https://cloud.debian.org/images/cloud/trixie/latest/debian-13-genericcloud-amd64.qcow2
  ## Fedora: https://download.fedoraproject.org/pub/fedora/linux/releases/44/Cloud/x86_64/images/Fedora-Cloud-Base-Generic-44-1.7.x86_64.qcow2
  url       = "https://download.fedoraproject.org/pub/fedora/linux/releases/44/Cloud/x86_64/images/Fedora-Cloud-Base-Generic-44-1.7.x86_64.qcow2"
  file_name = "fedora-cloud-44.qcow2"
}

resource "proxmox_virtual_environment_file" "vendor_data" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.target_node

  source_raw {
    data      = file("${path.module}/cloud-init/vendor-data.yaml")
    file_name = "fedora-vendor-data.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "fedora" {
  name      = var.vm_name
  node_name = var.target_node
  vm_id     = var.vm_id

  agent {
    enabled = true
  }

  cpu {
    cores = 4
    type  = "host"
  }

  memory {
    dedicated = var.memory
  }

  disk {
    datastore_id = var.datastore_id
    file_id      = proxmox_download_file.fedora_cloud_image.id
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
