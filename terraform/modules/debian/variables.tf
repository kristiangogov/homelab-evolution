variable "target_node" {
  type = string
}

variable "datastore_id" {
  type    = string
  default = "local-lvm"
}

variable "vm_name" {
  type    = string
  default = "test"
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

variable "cloud_image_id" {
  type = string
}