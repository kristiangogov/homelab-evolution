output "vm_ip" {
  value = proxmox_virtual_environment_vm.debian.ipv4_addresses
}