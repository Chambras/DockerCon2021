resource "azurerm_public_ip" "webPublicIP" {
  name                = "${var.suffix}-webPublicIP"
  location            = azurerm_resource_group.devVMRG.location
  resource_group_name = azurerm_resource_group.devVMRG.name
  allocation_method   = "Static"

  tags = var.tags
}

resource "azurerm_network_interface" "webNIC" {
  name                = "${var.suffix}-webNIC"
  location            = azurerm_resource_group.devVMRG.location
  resource_group_name = azurerm_resource_group.devVMRG.name

  ip_configuration {
    name                          = "webServer"
    subnet_id                     = data.azurerm_subnet.public.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.webPublicIP.id
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "webServer" {
  name                = "${var.suffix}-webServer"
  resource_group_name = azurerm_resource_group.devVMRG.name
  location            = azurerm_resource_group.devVMRG.location
  size                = "Standard_DS3_v2"
  admin_username      = var.vmUserName
  #  encryption_at_host_enabled = true
  network_interface_ids = [azurerm_network_interface.webNIC.id, ]

  admin_ssh_key {
    username   = var.vmUserName
    public_key = file(var.sshKeyPath)
  }

  os_disk {
    name                 = "${var.suffix}-webServerosDisk1"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 100
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = var.vmsku
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = data.azurerm_storage_account.mainSA.primary_blob_endpoint
  }


  # This is to ensure SSH comes up before we run the local exec.
  provisioner "remote-exec" {
    inline = ["echo 'Hello World'"]

    connection {
      type        = "ssh"
      host        = azurerm_public_ip.webPublicIP.ip_address
      user        = var.vmUserName
      private_key = file(var.sshPrvtKeyPath)
    }
  }

  provisioner "local-exec" {
    # ansible-playbook -i 40.70.209.100, -u webAdmin --private-key ~/.ssh/vm_ssh ../ansible/webServer/nginx_web.yml
    command = "ansible-playbook -i '${azurerm_public_ip.webPublicIP.ip_address},' -u ${var.vmUserName} --private-key ${var.sshPrvtKeyPath} ../ansible/nginxServer/nginx_web.yml"
    # ansible all -i '52.247.48.118,' --private-key ~/.ssh/vm_ssh -a 'uname -a' -u webAdmin
    # command = "ansible all -i '${azurerm_public_ip.webPublicIP.ip_address},' --private-key ${var.sshPrvtKeyPath} -a 'uname -a' -u ${var.vmUserName}"
    # command = "ansible-playbook -u ubuntu -i ‘${aws_instance.web.public_dns},’ main.yml"
  }

  tags = var.tags
}
