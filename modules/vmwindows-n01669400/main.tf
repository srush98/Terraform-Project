# File: modules/vmwindows-9400/main.tf

# Define the Azure Availability Set for Windows VMs
resource "azurerm_availability_set" "windows" {
  name                         = "${var.prefix}-AVSET-Windows"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed                      = true

  tags = var.tags
}

# Define the Azure Public IP Address for Windows VMs
resource "azurerm_public_ip" "win-pip" {
  count               = var.vm_win_count
  name                = "${var.prefix}-PIP-Windows-${count.index}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.prefix}-win-${count.index}"

  tags = var.tags
}

# Define the Azure Network Interface for Windows VMs
resource "azurerm_network_interface" "win-nic" {
  count               = var.vm_win_count
  name                = "${var.prefix}-NIC-Windows-${count.index}"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.win-pip[count.index].id
  }

  tags = var.tags
}

# Define the Azure Windows Virtual Machine
resource "azurerm_windows_virtual_machine" "win-vm" {
  count               = var.vm_win_count
  name                = "${var.prefix}-VM-Win-${count.index}"
  resource_group_name = var.resource_group_name
  location            = var.location
  availability_set_id = azurerm_availability_set.windows.id
  size                = var.vm_size
  admin_username      = "adminuser"
  admin_password      = var.admin_password

  network_interface_ids = [azurerm_network_interface.win-nic[count.index].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.storage_type
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = "https://${var.storage_account_name}.blob.core.windows.net/"
  }

  tags = var.tags
}

# Define the Azure Virtual Machine Extension for Antimalware
resource "azurerm_virtual_machine_extension" "antimalware" {
  count                = var.vm_win_count
  name                 = "IaaSAntimalware"
  virtual_machine_id   = azurerm_windows_virtual_machine.win-vm[count.index].id
  publisher            = "Microsoft.Azure.Security"
  type                 = "IaaSAntimalware"
  type_handler_version = "1.3"

  settings = <<SETTINGSJSON
    {
      "AntimalwareEnabled": true
    }
  SETTINGSJSON
}