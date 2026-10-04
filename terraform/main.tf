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

module "debian" {
  source = "./modules/debian"

  for_each = {
    debian-01 = {
      vm_id       = 555
      target_node = var.target_node
    }

    # debian-02 = {
    #   vm_id       = 556
    #   target_node = var.target_node
    # }
  }

  target_node        = each.value.target_node
  datastore_id       = var.datastore_id
  image_datastore_id = var.image_datastore_id
  ci_user            = var.ci_user
  ci_password        = var.ci_password

  ci_ssh_key = var.ci_ssh_key

  vm_name = each.key
  vm_id   = each.value.vm_id
}
