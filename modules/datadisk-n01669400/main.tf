resource "azurerm_managed_disk" "disks" {
  for_each = tomap({ for idx, val in var.linux_vm_ids : idx => val })

  name                 = "${var.prefix}-DATADISK-${each.key}"
  resource_group_name  = var.resource_group_name
  location             = var.location
  storage_account_type = var.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = 10
  tags                 = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "linux_disks" {
  for_each           = tomap({ for idx, val in var.linux_vm_ids : idx => val })
  managed_disk_id    = azurerm_managed_disk.disks[each.key].id
  virtual_machine_id = each.value
  lun                = 0
  caching            = "ReadWrite"
}

# Windows VM - A separate managed disk
resource "azurerm_managed_disk" "windows_disk" {
  name                 = "${var.prefix}-WIN-DISK"
  resource_group_name  = var.resource_group_name
  location             = var.location
  storage_account_type = var.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = 10
  tags                 = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "windows_disk" {
  managed_disk_id    = azurerm_managed_disk.windows_disk.id
  virtual_machine_id = var.windows_vm_id
  lun                = 1
  caching            = "ReadWrite"
}
