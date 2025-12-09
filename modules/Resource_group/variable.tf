variable "rgs" {
    type = map(object({
      rgname = string
      location = string
      managed_by = string
        tags = map(string) 
    }))
  
}