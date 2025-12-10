variable "vms" {
  type = map(object({
    vmname                                                 = string
    location                                               = string
    rgname                                                 = string
    size                                                   = string
    admin_username                                         = string
    admin_password                                         = string
    nicname                                                = string
    AvailabilitySetname                                    = string
    license_type                                           = optional(string)
    allow_extension_operations                             = optional(string)
    bypass_platform_safety_checks_on_user_schedule_enabled = optional(string)
    computer_name                                          = optional(string)
    disk_controller_type                                   = optional(string)

    os_disk = map(object({
      caching              = string
      storage_account_type = optional(string)
    }))

    source_image_reference = map(object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    }))

    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))


    boot_diagnostics = optional(object({
      enabled     = string
      storage_uri = optional(string)
    }))
  }))

}
