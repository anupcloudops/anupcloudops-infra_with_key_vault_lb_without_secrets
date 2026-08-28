data "azurerm_subnet" "datasub"{
    for_each = var.lb
    name = each.value.subname
    resource_group_name = each.value.rgname
    virtual_network_name = each.value.vnet
}
data "azurerm_public_ip" "datapip" {
     for_each = var.lb
    name = each.value.pipname
   resource_group_name = each.value.rgname
}