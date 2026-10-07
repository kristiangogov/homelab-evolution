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

variable "ssh_username" {
  type    = string
  default = "root"
}

variable "node_ip" {
  type = string
}

variable "vms" {
  type = map(object({
    type        = string
    vm_id       = number
    ip_address  = string
    memory      = number
    cores       = number
    target_node = optional(string)
  }))
}

variable "enabled_vms" {
  type    = set(string)
  default = []
}