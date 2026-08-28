data "azurerm_network_security_group" "datansg" {
    for_each = var.association
    name = each.value.nsgname
    resource_group_name = each.value.rgname
}

data "azurerm_network_interface" "datanic"{
    for_each = var.association
    name = each.value.nicname
    resource_group_name = each.value.rgname
}