resource "azurerm_storage_account" "stg" {
  for_each                         = var.stgs
  name                             = each.value.stgname
  resource_group_name              = each.value.rgname
  location                         = each.value.location
  account_tier                     = each.value.account_tier
  account_replication_type         = each.value.account_replication_type
  cross_tenant_replication_enabled = lookup(each.value, "cross_tenant_replication_enabled", false)
  access_tier                      = lookup(each.value, "access_tier", "Hot")
  https_traffic_only_enabled       = lookup(each.value, "https_traffic_only_enabled", true)
  min_tls_version                  = lookup(each.value, "min_tls_version", "TLS1_2")
  allow_nested_items_to_be_public  = lookup(each.value, "allow_nested_items_to_be_public", false)
  shared_access_key_enabled        = lookup(each.value, "shared_access_key_enabled", true)
  default_to_oauth_authentication  = lookup(each.value, "default_to_oauth_authentication", false)
  nfsv3_enabled                    = lookup(each.value, "nfsv3_enabled", false)

  dynamic "network_rules" {
    for_each = each.value.network_rules
    content {
      default_action = network_rules.value.default_action #"Deny"
      ip_rules       = network_rules.value.ip_rules       #["100.0.0.1"]
    }

  }

  tags = each.value.tags
}