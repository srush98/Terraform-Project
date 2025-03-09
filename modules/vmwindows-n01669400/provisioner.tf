# File: modules/vmwindows-9400/provisioner.tf

# Define a null_resource to display the hostname of the Windows VM
resource "null_resource" "display_hostname_windows" {
  depends_on = [azurerm_windows_virtual_machine.win-vm]

  count = var.vm_win_count

  connection {
    type     = "winrm"
    host     = azurerm_public_ip.win-pip[count.index].ip_address
    user     = "adminuser"
    password = var.admin_password # Provide the correct password
  }

  provisioner "remote-exec" {
    inline = [
      "Sleep 60",
      "hostname" # Command to display the hostname of the Windows VM
    ]
  }
}
