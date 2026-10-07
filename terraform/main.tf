resource "proxmox_download_file" "debian_cloud_image" {
  content_type = "import"
  datastore_id = "local"
  node_name    = "elitedesk"

  url       = "https://cloud.debian.org/images/cloud/trixie/latest/debian-13-genericcloud-amd64.qcow2"
  file_name = "debian-13-trixie.qcow2"
}

locals {
  enabled_vms = {
    for name, vm in var.vms :
    name => vm
    if contains(var.enabled_vms, name)
  }

  debian_vms = {
    for name, vm in local.enabled_vms :
    name => vm
    if vm.type == "debian"
  }

  fedora_vms = {
    for name, vm in local.enabled_vms :
    name => vm
    if vm.type == "fedora"
  }
}

module "debian" {
  source = "./modules/debian"

  for_each = local.debian_vms

  target_node = coalesce(
    each.value.target_node,
    var.target_node
  )

  datastore_id   = var.datastore_id
  cloud_image_id = proxmox_download_file.debian_cloud_image.id
  ip_address     = each.value.ip_address

  ci_user     = var.ci_user
  ci_password = var.ci_password
  ci_ssh_key  = var.ci_ssh_key

  vm_name = each.key
  vm_id   = each.value.vm_id

  memory = each.value.memory
  cores  = each.value.cores
}

module "fedora" {
  source = "./modules/fedora"

  for_each = local.fedora_vms

  target_node = coalesce(
    each.value.target_node,
    var.target_node
  )

  datastore_id       = var.datastore_id
  image_datastore_id = var.image_datastore_id

  vm_name = each.key
  vm_id   = each.value.vm_id

  ci_user     = var.ci_user
  ci_password = var.ci_password
  ci_ssh_key  = var.ci_ssh_key

  memory = each.value.memory
  cores  = each.value.cores
}

