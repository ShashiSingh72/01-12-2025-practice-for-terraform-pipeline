resource "azurerm_subnet" "subnet" {
  for_each             = var.subnets
  name                 = each.value.subnetname
  resource_group_name  = each.value.rgname
  virtual_network_name = each.value.vnetname
  address_prefixes     = each.value.address_prefixes #["10.0.1.0/24"]

  dynamic "delegation" {
    for_each = each.value.delegations == null ? [] : each.value.delegations
    content {
      name = lookup(delegation.value, "name", null)

      service_delegation {
        name    = "Microsoft.ContainerInstance/containerGroups"
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
      }
    }
  }

}





variable "subnets" {
  type = map(object({
    subnetname       = string
    rgname           = string
    vnetname         = string
    address_prefixes = list(string)
    delegations = optional(list(object({
      name = string
    })))
  }))
}
