variable "chat_id" {
  type        = string
  description = "Telegram group chat ID"
}

variable "telegram_token" {
  type        = string
  description = "Telegram API token"
}

variable "env" {
  type        = string
  description = "Environment"
  default     = "prod"
}

variable "region" {
  type        = string
  description = "AWS region"
}