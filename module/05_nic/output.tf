output "nic_ids" {
  value = {
    for key, nic in azurerm_network_interface.nic :
    key => nic.id
  }
}

output "nic_private_ips" {
  value = {
    for key, nic in azurerm_network_interface.nic :
    key => nic.private_ip_address
  }
}

output "nic_ip_configuration_names" {
  value = {
    for key, nic in azurerm_network_interface.nic :
    key => nic.ip_configuration[0].name
  }
}