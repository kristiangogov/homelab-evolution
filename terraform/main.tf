resource "proxmox_download_file" "debian_cloud_image" {
  content_type = "import"
  datastore_id = "local"
  node_name    = "elitedesk"

  url       = "https://cloud.debian.org/images/cloud/trixie/latest/debian-13-genericcloud-amd64.qcow2"
  file_name = "debian-13-trixie.qcow2"
}


module "debian" {
  source = "./modules/debian"

  for_each = {
    production = {
      vm_id       = 100
      target_node = var.target_node
    }

    dev = {
      vm_id       = 101
      target_node = var.target_node
    }
  }

  target_node        = each.value.target_node
  datastore_id       = var.datastore_id
  cloud_image_id     = proxmox_download_file.debian_cloud_image.id


  ci_user            = var.ci_user
  ci_password        = var.ci_password
  ci_ssh_key = var.ci_ssh_key

  vm_name = each.key
  vm_id   = each.value.vm_id
}

# module "fedora" {
#   source = "./modules/fedora"

#   target_node        = var.target_node
#   datastore_id       = var.datastore_id
#   image_datastore_id = var.image_datastore_id
#   vm_name            = "fedora-test"
#   vm_id              = 444
#   ci_user            = var.ci_user
#   ci_password        = var.ci_password
#   ci_ssh_key         = var.ci_ssh_key
# }

