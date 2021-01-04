variable "function_name" {
  type        = string
  description = "Function name"
}

variable "handler" {
  type        = string
  description = "Function handler"
}

variable "runtime" {
  type        = string
  description = "Function runtime"
}

variable "package_name" {
  type        = string
  description = "Function package name"
}

variable "environment_variables" {
  type        = map(string)
  description = "Function environment variables"
  default     = {}
}