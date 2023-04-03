# Generate admin password
resource "random_password" "admin-linux" {
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
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.vm_name
  size                            = var.vm_instance_size
  resource_group_name             = var.rg_name
  location                        = var.rg_location
  allow_extension_operations      = false
  computer_name                   = var.vm_name
  admin_username                  = var.vm_admin_user
  admin_password                  = random_password.admin-linux.result
  disable_password_authentication = true
  admin_ssh_key {
    username   = var.vm_admin_user
    public_key = file("./ssh_keys/terraform.pub")
  }
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
