# Filename: modules/vmlinux-n01669400/provisioner.tf

# Define a null_resource to display the hostname of the Linux VM
resource "null_resource" "display_hostname" {
  depends_on = [azurerm_linux_virtual_machine.linux-vm]

  connection {
    type        = "ssh"
    host        = azurerm_public_ip.linux-pip["0"].ip_address
    user        = "adminuser"
    private_key = file("~/.ssh/id_rsa")
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'VM hostname: $(hostname)'"
    ]
  }
}
