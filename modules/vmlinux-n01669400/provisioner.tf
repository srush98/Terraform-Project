# Filename: modules/vmlinux-n01669400/provisioner.tf

# Define a null_resource to display the hostname of the Linux VM
resource "null_resource" "display_hostname" {
  for_each = toset([for i in range(var.vm_linux_count) : tostring(i)])

  depends_on = [
    azurerm_linux_virtual_machine.linux-vm,
    azurerm_public_ip.linux-pip
  ]

  connection {
    type        = "ssh"
    host        = azurerm_public_ip.linux-pip[each.key].ip_address
    user        = "adminuser"
    private_key = file("~/.ssh/id_rsa")
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Provisioning completed for:' $(hostname)"
    ]
  }
}
