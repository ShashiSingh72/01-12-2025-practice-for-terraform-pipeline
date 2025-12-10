resource "azurerm_linux_virtual_machine" "vm" {
  for_each                                               = var.vms
  name                                                   = each.value.vmname
  resource_group_name                                    = each.value.rgname
  location                                               = each.value.location
  size                                                   = each.value.size #"Standard_F2"
  admin_username                                         = each.value.admin_username
  admin_password                                         = each.value.admin_password
  license_type                                           = lookup(each.value, "license_type", null)               #"Ubuntu_Server"
  allow_extension_operations                             = lookup(each.value, "allow_extension_operations", null) # "true"
  availability_set_id                                    = data.azurerm_availability_set.data_as[each.key].id
  bypass_platform_safety_checks_on_user_schedule_enabled = lookup(each.value, "bypass_platform_safety_checks_on_user_schedule_enabled", null) # "false"
  computer_name                                          = lookup(each.value, "computer_name", null)
  disk_controller_type                                   = lookup(each.value, "disk_controller_type", null) # "SCSI"
  edge_zone                                              = lookup(each.value, "edge_zone", null)
  encryption_at_host_enabled                             = lookup(each.value, "encryption_at_host_enabled", null) # "true"
  eviction_policy                                        = lookup(each.value, "eviction_policy", null)            # "Deallocate"
  extensions_time_budget                                 = lookup(each.value, "extensions_time_budget", null)     # "PT1H30M"
  patch_assessment_mode                                  = lookup(each.value, "patch_assessment_mode", null)      # "ImageDefault"
  provision_vm_agent                                     = lookup(each.value, "provision_vm_agent", null)         # "true"
  patch_mode                                             = lookup(each.value, "patch_mode", null)                 # "AutomaticByPlatform"


  network_interface_ids           = [data.azurerm_network_interface.data_nic[each.key].id, ]
  disable_password_authentication = false

  # optional ssh key block
  #   admin_ssh_key {
  #     username   = "adminuser"
  #     public_key = file("~/.ssh/id_rsa.pub")
  #   }

  dynamic "os_disk" {
    for_each = each.value.os_disk
    content {
      caching              = os_disk.value.caching     #"ReadWrite"
      storage_account_type = lookup(os_disk.value, "storage_account_type", null) #"Standard_LRS"
  }
  }


  dynamic "source_image_reference" {
    for_each = each.value.source_image_reference
    content {
    publisher = source_image_reference.value.publisher      #"Canonical"
    offer     = source_image_reference.value.offer   #"0001-com-ubuntu-server-jammy"
    sku       = source_image_reference.value.sku    #"22_04-lts"
    version   = source_image_reference.value.version  #"latest"
  }
  }
  # optional managed identity block
  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      type = lookup(identity.value, "type", null)
    }
  }


  # optional boot diagnostics block
  dynamic "boot_diagnostics" {
    for_each = each.value.boot_diagnostics != null ? [each.value.boot_diagnostics] : []
    content {
      storage_account_uri = lookup(boot_diagnostics.value, "storage_account_uri", null)
    }
  }
}





