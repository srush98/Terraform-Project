# File: modules/datadisk/outputs.tf

output "linux_managed_disk_names" {
  description = "The managed disk names for the Linux VMs."
  value       = { for k, v in azurerm_managed_disk.disks : k => v.name }
}

output "linux_disk_attachments" {
  description = "The data disk attachment details for the Linux VMs."
  value       = { for k, v in azurerm_virtual_machine_data_disk_attachment.linux_disks : k => v.lun }
}

output "windows_managed_disk_name" {
  description = "The managed disk name for the Windows VM."
  value       = azurerm_managed_disk.windows_disk.name
}

output "windows_disk_attachment" {
  description = "The data disk attachment LUN for the Windows VM."
  value       = azurerm_virtual_machine_data_disk_attachment.windows_disk.lun
}
