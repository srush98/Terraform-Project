# File: modules/vmlinux-9400/main.tf

# Define the Azure Availability Set for Linux VMs
resource "azurerm_availability_set" "linux" {
  name                         = "${var.prefix}-AVSET-LINUX"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed                      = true
  tags                         = var.tags
}

# Define the Azure Public IP Address for Linux VMs
resource "azurerm_public_ip" "linux-pip" {
  for_each            = toset(["0", "1", "2"])
  name                = "${var.prefix}-PIP-LINUX-${each.key}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.prefix}-linux${each.key}"
  tags                = var.tags
}

# Define the Azure Network Interface for Linux VMs
resource "azurerm_network_interface" "linux-nic" {
  for_each            = toset(["0", "1", "2"])
  name                = "${var.prefix}-NIC-LINUX-${each.key}"
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
  for_each                        = toset(["0", "1", "2"])
  name                            = "${var.prefix}-VM-LINUX-${each.key}"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  availability_set_id             = azurerm_availability_set.linux.id
  size                            = "Standard_B1ms"
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
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = "https://${var.storage_account_name}.blob.core.windows.net/"
  }

  tags = var.tags
}
