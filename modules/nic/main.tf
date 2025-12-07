resource "azurerm_network_interface" "nic" {
  for_each            = var.nics
  name                = each.value.nicname
  location            = each.value.location
  resource_group_name = each.value.rgname

  dynamic "ip_configuration" {
    for_each = each.value.ip_configuration
    content {
      name                          = ip_configuration.value.name             #"internal"
      subnet_id                     = data.azurerm_subnet.data_subnet[each.key].id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation           #"Dynamic"
    }
  }
}

data "azurerm_subnet" "data_subnet" {
  for_each             = var.nics
  name                 = each.value.subnetname
  virtual_network_name = each.value.vnetname
  resource_group_name  = each.value.rgname

}
variable "nics" {
  type = map(object({
    nicname    = string
    location   = string
    rgname     = string
    subnetname = string
    vnetname   = string
    ip_configuration = map(object({
      name                          = string
      private_ip_address_allocation = string
    }))
  }))
}
