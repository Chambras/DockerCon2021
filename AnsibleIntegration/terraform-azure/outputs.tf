output "devVMRG" {
  value = azurerm_resource_group.devVMRG.name
}

output "webPublicIP" {
  value = azurerm_public_ip.webPublicIP.ip_address
}

output "webPrivateIP" {
  value = azurerm_network_interface.webNIC.private_ip_address
}

output "sshAccess" {
  description = "Command to ssh into the VM."
  sensitive   = false
  value       = <<SSHCONFIG
  ssh ${var.vmUserName}@${azurerm_public_ip.webPublicIP.ip_address} -i ~/.ssh/vm_ssh
  SSHCONFIG
}
