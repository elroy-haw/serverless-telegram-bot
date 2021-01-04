variable "name" {
  type        = string
  description = "Name of API"
}

variable "env" {
  type        = string
  description = "Environment which will be used as stage"
}

variable "lambda_integrations" {
  type        = map(string)
  description = "Map of route keys to Lambda invocation ARNs"
}