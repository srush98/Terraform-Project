# Filename: modules/vmwindows-n01669400/provisioner.tf

# Provisioner for the VM Windows instance
resource "null_resource" "display_windows_hostname" {
  depends_on = [azurerm_windows_virtual_machine.win-vm]

  connection {
    type     = "winrm"
    host     = azurerm_public_ip.win-pip[0].ip_address
    user     = "adminuser"
    password = var.admin_password
  }

  provisioner "remote-exec" {
    inline = [
      "hostname"
    ]
  }
}
