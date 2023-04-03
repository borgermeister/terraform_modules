output "vm_nic_ip" {
  value = azurerm_network_interface.nic.private_ip_address
}

output "vm_admin_password" {
  value = random_password.admin-windows.result
}