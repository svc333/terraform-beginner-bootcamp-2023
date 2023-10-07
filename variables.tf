variable "user_uuid" {
  type        = string
  description = "User UUID in a specific format"
  
  validation {
    condition     = can(regex("^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$", var.user_uuid))
    error_message = "User UUID must be in the format 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx', where 'x' is a hexadecimal digit."
  }
}
