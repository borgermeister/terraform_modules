variable "tags" {
  type        = map(string)
  description = "Map of tags to be applied to all resources"
  default     = {}
}

variable "rg_name" {
  type = string
  description = "Resource Group name"
}

variable "rg_location" {
  type = string
  description = "Resource Group location"
}

variable "vm_name" {
  type = string
  description = "Virtual Machine name"
}

variable "vm_admin_user" {
  description = "Virtual Machine Administrator user"
  sensitive   = true
  default     = "terraform"
}

variable "vm_admin_password" {
  description = "Virtual Machine Administrator password"
  sensitive   = true
  default     = "password"
}

variable "vm_instance_size" {
  type        = string
  description = "Azure VM instance size"
  default     = "Standard_B2ms"
}

variable "vm_os" {
  type = map(any)
  default = {
    "publisher" = "Canonical"
    "offer"     = "0001-com-ubuntu-server-jammy"
    "sku"       = "22_04-lts-gen2"
    "version"   = "latest"
  }
}

variable "nic_name" {
  type = string
  description = "Network Inferface Card name"
}

variable "nic_ip_name" {
  type = string
  description = "Network Interface Card IP name"
  default = "internal"
}
variable "disk_name" {
  type = string
  description = "Virtual Machine Disk name"
}

variable "storage_account_type" {
  type = string
  description = "Virtual Machine Disk Storage Account type"
  default = "Standard_LRS"
}
variable "disk_size_gb" {
  type = number
  description = "Virtual Machine Disk size"
  default = 30
}
variable "subnet_id" {
  description = "Azure subnet"
}
