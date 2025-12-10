
data "azurerm_availability_set" "data_as" {
  for_each            = var.vms
  name                = each.value.AvailabilitySetname
  resource_group_name = each.value.rgname
}

data "azurerm_network_interface" "data_nic" {
  for_each            = var.vms
  name                = each.value.nicname
  resource_group_name = each.value.rgname
}
