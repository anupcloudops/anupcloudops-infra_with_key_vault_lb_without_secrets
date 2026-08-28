
resource "azurerm_bastion_host" "bastion" {
  for_each = var.bastion

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.rgname
  sku                 = "Standard"

  ip_configuration {
    name                 = "bastion-ip-config"
    subnet_id            = data.azurerm_subnet.datasub[each.key].id
    public_ip_address_id = data.azurerm_public_ip.datapip[each.key].id
  }
}