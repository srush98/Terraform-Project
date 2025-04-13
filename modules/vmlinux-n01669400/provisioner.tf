# Filename: modules/vmlinux/provisioner.tf

resource "null_resource" "ansible_provision" {
  for_each = toset([for i in range(var.vm_linux_count) : tostring(i)])

  triggers = {
    disks_ready = join(",", var.linux_disk_ids)
  }

  depends_on = [
    azurerm_linux_virtual_machine.linux-vm    ]


  # SSH Connection to the VM
  connection {
    type        = "ssh"
    host        = azurerm_public_ip.linux-pip[each.key].fqdn
    user        = "adminuser"
    private_key = file("~/.ssh/id_rsa")
  }

  # Verify connection to VM
  provisioner "remote-exec" {
      inline = [
        "echo VM Connected: $(hostname)"
      ]
    }

  # Run Ansible Playbook
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini n01669400-playbook.yml"
  }
}
