resource "azurerm_virtual_network" "vnet" {
  for_each                       = var.vnets
  name                           = each.value.vnetname
  location                       = each.value.location
  resource_group_name            = each.value.rgname
  address_space                  = lookup(each.value, "address_space", null)
  dns_servers                    = lookup(each.value, "dns_servers", [])
  edge_zone                      = lookup(each.value, "edge_zone", null)
  private_endpoint_vnet_policies = lookup(each.value, "private_endpoint_vnet_policies", "Disabled")

  dynamic "ip_address_pool" {
    for_each = each.value.ip_address_pool == null ? [] : [each.value.ip_address_pool]
    content {
      id                     = ip_address_pool.value.id
      number_of_ip_addresses = ip_address_pool.value.number_of_ip_addresses
    }
  }


  # DDoS
  dynamic "ddos_protection_plan" {
    for_each = each.value.ddos_protection_plan == null ? [] : [each.value.ddos_protection_plan]
    content {
      id     = ddos_protection_plan.value.id
      enable = ddos_protection_plan.value.enable
    }
  }

  # Encryption
  dynamic "encryption" {
    for_each = lookup(each.value, "encryption", null) != null ? [each.value.encryption] : []
    content {
      enforcement = encryption.value.enforcement
    }
  }

  # VNet tags
  tags = lookup(each.value, "tags", {})
}



variable "vnets" {
  type = map(object({
    vnetname                       = string
    location                       = string
    rgname                         = string
    address_space                  = optional(list(string))
    dns_servers                    = optional(list(string))
    edge_zone                      = optional(string)
    private_endpoint_vnet_policies = optional(string)

    ip_address_pool = optional(map(object({
      id                     = string
      number_of_ip_addresses = number
    })))

    ddos_protection_plan = optional(map(object({
      id     = string
      enable = string
    })))

    encryption = optional(object({
        enforcement = string
    }))


    tags = map(string)
  }))
}
