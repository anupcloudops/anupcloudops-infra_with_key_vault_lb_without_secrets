output "public_ip"{
    value = {for k ,v in azurerm_public_ip.pip : k=>v.ip_address}
}