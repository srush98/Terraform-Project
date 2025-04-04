# Filename: modules/vmlinux/provisioner.tf

resource "null_resource" "ansible_provision" {
  for_each = toset([for i in range(var.vm_linux_count) : tostring(i)])

  depends_on = [azurerm_linux_virtual_machine.linux-vm]

  # SSH Connection to the VM
  connection {
    type        = "ssh"
    host        = azurerm_public_ip.linux-pip[each.key].fqdn
    user        = "adminuser"
    private_key = file("~/.ssh/id_rsa")
  }

  # # Remove old SSH keys before provisioning
  # provisioner "local-exec" {
  #   command = "ssh-keygen -f ~/.ssh/known_hosts -R ${azurerm_public_ip.linux-pip[each.key].fqdn}"
  # }
  
   # Verify connection to VM
  provisioner "remote-exec" {
      inline = [
        "echo Hostname: $(hostname)"
      ]
    }
  
  # Run Ansible Playbook
  provisioner "local-exec" {
    command = "ansible-playbook -i ./ansible/inventory.ini ./ansible/n01669400-playbook.yml"
  }
}
