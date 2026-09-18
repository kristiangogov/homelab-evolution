module "fedora" {
  source = "./modules/fedora"

  target_node        = var.target_node
  datastore_id       = var.datastore_id
  image_datastore_id = var.image_datastore_id
  vm_name            = var.vm_name
  vm_id              = var.vm_id
  ci_user            = var.ci_user
  ci_ssh_key         = var.ci_ssh_key
}
