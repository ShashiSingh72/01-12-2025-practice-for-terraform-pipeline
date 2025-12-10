resource "azurerm_availability_set" "my_as" {
  for_each            = var.avsets
  name                = each.value.AvailabilitySetname # "myAvailabilitySet"
  location            = each.value.location
  resource_group_name = each.value.rgname

  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
}




variable "avsets" {
  type = map(object({
    AvailabilitySetname = string
    location            = string
    rgname              = string
  }))

}
