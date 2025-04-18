# File: modules/vmlinux-9400/main.tf

# Define the Azure Availability Set for Linux VMs
resource "azurerm_availability_set" "linux" {
  name                         = "${var.prefix}-AVSET-Linux"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed                      = true
  tags                         = var.tags
}

# Define the Azure Public IP Address for Linux VMs
resource "azurerm_public_ip" "linux-pip" {
  for_each            = toset([for i in range(var.vm_linux_count) : tostring(i)])
  name                = "${var.prefix}-PIP-Linux-${each.key}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "${var.prefix}-linux-${each.key}"
  tags                = var.tags
}

# Define the Azure Network Interface for Linux VMs
resource "azurerm_network_interface" "linux-nic" {
  for_each            = toset([for i in range(var.vm_linux_count) : tostring(i)])
  name                = "${var.prefix}-NIC-Linux-${each.key}"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux-pip[each.key].id
  }
  tags = var.tags
}

# Define the Azure Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "linux-vm" {
  for_each                        = toset([for i in range(var.vm_linux_count) : tostring(i)])
  name                            = "${var.prefix}-VM-Linux-${each.key}"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  availability_set_id             = azurerm_availability_set.linux.id
  size                            = var.vm_linux_size
  admin_username                  = "adminuser"
  disable_password_authentication = true
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  network_interface_ids = [azurerm_network_interface.linux-nic[each.key].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.linux_image["publisher"]
    offer     = var.linux_image["offer"]
    sku       = var.linux_image["sku"]
    version   = var.linux_image["version"]
  }

  boot_diagnostics {
    storage_account_uri = "https://${var.storage_account_name}.blob.core.windows.net/"
  }

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "linux_network_watcher" {
  for_each                   = toset([for i in range(var.vm_linux_count) : tostring(i)])
  name                       = "${each.key}-netwatcher"
  virtual_machine_id         = azurerm_linux_virtual_machine.linux-vm[each.key].id
  publisher                  = "Microsoft.Azure.NetworkWatcher"
  type                       = "NetworkWatcherAgentLinux"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
}

resource "azurerm_virtual_machine_extension" "linux_azure_monitor" {
  for_each                   = toset([for i in range(var.vm_linux_count) : tostring(i)])
  name                       = "${each.key}-azuremonitor"
  virtual_machine_id         = azurerm_linux_virtual_machine.linux-vm[each.key].id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
}
