output "webhook" {
  value = join("/",
    [
      module.telegram_webhook.invoke_url,
      "telegram-bot"
    ]
  )
  description = "Set this as your Telegram bot's webhook"
}