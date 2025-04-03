# Filename: modules/vmlinux/provisioner.tf

# modules/vmlinux/provisioner.tf

resource "null_resource" "ansible_provision" {
  for_each = toset([for i in range(var.vm_linux_count) : tostring(i)])
  depends_on = [azurerm_linux_virtual_machine.linux-vm]

  connection {
    type        = "ssh"
    host        = azurerm_public_ip.linux-pip[each.key].fqdn
    user        = "adminuser"
    private_key = file("~/.ssh/id_rsa")
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i ${azurerm_public_ip.linux-pip[each.key].fqdn}, ./ansible/n01669400-playbook.yml"
  }
}
