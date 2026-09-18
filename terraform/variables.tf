variable "proxmox_endpoint" {
  type = string
}

variable "proxmox_api_token" {
  type      = string
  sensitive = true
}

variable "proxmox_insecure" {
  type    = bool
  default = false
}

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

variable "ci_ssh_key" {
  type = string
}

variable "ssh_username" {
  type    = string
  default = "root"
}

variable "node_ip" {
  type = string
}