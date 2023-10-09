variable "user_uuid" {
  type        = string
  description = "User UUID in a specific format"
  
  validation {
    condition     = can(regex("^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$", var.user_uuid))
    error_message = "User UUID must be in the format 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx', where 'x' is a hexadecimal digit."
  }
}
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  # You can add more validation rules if needed
}

variable "index_html_filepath" {
  description = "The file path for index.html"
  type = string


validation {
  condition = fileexists(var.index_html_filepath)
  error_message = "the provided path for index.html does not exist."
}
}

variable "error_html_filepath" {
  description = "The file path for error.html"
  type = string


validation {
  condition = fileexists(var.error_html_filepath)
  error_message = "the provided path for error.html does not exist."
}
}

variable "content_version" {
  description = "The content version. Should be a positive integer starting at 1."
  type        = number

  validation {
    condition     = var.content_version > 0 && floor(var.content_version) == var.content_version
    error_message = "The content_version must be a positive integer starting at 1."
  }
}

variable "assets_path" {
  description = "path to ass"
  type = string
}