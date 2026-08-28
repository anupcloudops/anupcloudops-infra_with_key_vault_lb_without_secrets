resource "azurerm_lb" "lb" {
  for_each = var.lb

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.rgname
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "frontend"
    public_ip_address_id = data.azurerm_public_ip.datapip[each.key].id
  }
}

resource "azurerm_lb_backend_address_pool" "backend" {
  for_each = azurerm_lb.lb

  name            = "backend-pool"
  loadbalancer_id = each.value.id
}

resource "azurerm_lb_probe" "probe" {
  for_each = azurerm_lb.lb

  name            = "http-probe"
  loadbalancer_id = each.value.id
  protocol        = "Http"
  port            = 80
  request_path    = "/"
}

resource "azurerm_lb_rule" "rule" {
  for_each = azurerm_lb.lb

  name                           = "http-rule"
  loadbalancer_id                = each.value.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "frontend"

  backend_address_pool_ids = [
    azurerm_lb_backend_address_pool.backend[each.key].id
  ]

  probe_id = azurerm_lb_probe.probe[each.key].id
}

resource "azurerm_network_interface_backend_address_pool_association" "backend" {

  for_each = var.nic_ids

  network_interface_id   = each.value
  ip_configuration_name  = var.nic_ip_configuration_names[each.key]

  backend_address_pool_id = azurerm_lb_backend_address_pool.backend["lb1"].id
}