resource "null_resource" "lambda_package" {
  triggers = {
    redeploy = filebase64sha256("${path.module}/lambda/src/telegram_bot.py")
  }

  provisioner "local-exec" {
    command = join(" && ",
      [
        "rm -f lambda_package.zip",
        "cd ${path.module}/lambda/src/venv/lib/python3.8/site-packages",
        "zip -r9q $${OLDPWD}/lambda_package.zip .",
        "cd $${OLDPWD}",
        "cd ${path.module}/lambda/src",
        "zip -gq $${OLDPWD}/lambda_package.zip telegram_bot.py"
      ]
    )
  }
}

module "telegram_bot" {
  source = "./lambda"

  function_name = "telegram-bot"
  handler       = "telegram_bot.lambda_handler"
  runtime       = "python3.8"
  package_name  = "lambda_package.zip"

  environment_variables = {
    CHAT_ID        = var.chat_id
    TELEGRAM_TOKEN = var.telegram_token
  }
}

module "telegram_webhook" {
  source = "./apigateway"

  name = "telegram-webhook"
  env  = var.env

  lambda_integrations = {
    telegram-bot = module.telegram_bot.function.invoke_arn
  }
}