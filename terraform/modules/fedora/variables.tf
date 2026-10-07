variable "target_node" {
  type = string
}

variable "datastore_id" {
  type    = string
  default = "local-lvm"
}

variable "image_datastore_id" {
  type    = string
  default = "local"
}

variable "vm_name" {
  type    = string
  default = "fedora-test"
}

variable "vm_id" {
  type    = number
  default = 9000
}

variable "ci_user" {
  type = string
}

variable "ci_password" {
  type      = string
  sensitive = true
}

variable "ci_ssh_key" {
  type = string
}

variable "memory" {
  type    = number
}