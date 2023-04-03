resource "random_password" "admin-windows" {
  length           = 16
  special          = true
  min_lower        = 2
  min_upper        = 2
  min_numeric      = 2
  min_special      = 2
  override_special = "*!@#?"
}

# Create NIC
resource "azurerm_network_interface" "nic" {
  name                = "${var.nic_name}-${var.vm_name}"
  location            = var.rg_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = var.nic_ip_name
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet_id
  }
  tags = var.tags
}

# Create VM
resource "azurerm_windows_virtual_machine" "vm" {
  name                       = var.vm_name
  size                       = var.vm_instance_size
  resource_group_name        = var.rg_name
  location                   = var.rg_location
  secure_boot_enabled        = false
  encryption_at_host_enabled = false
  allow_extension_operations = true
  computer_name              = var.vm_name
  admin_username             = var.vm_admin_user
  admin_password             = random_password.admin-windows.result
  patch_assessment_mode      = "AutomaticByPlatform"

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  boot_diagnostics {}

  source_image_reference {
    publisher = var.vm_os["publisher"]
    offer     = var.vm_os["offer"]
    sku       = var.vm_os["sku"]
    version   = var.vm_os["version"]
  }

  os_disk {
    name                 = "${var.disk_name}-${var.vm_name}"
    disk_size_gb         = var.disk_size_gb
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }
  tags = var.tags
}
