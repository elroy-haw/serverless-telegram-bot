# Serverless Telegram Bot
Hello world project to create a serverless telegram bot

## Pre-requisites
1. Telegram bot created via @BotFather
2. [Terraform](https://www.terraform.io/downloads.html) downloaded and [pre-requisites](https://learn.hashicorp.com/tutorials/terraform/aws-build#prerequisites) completed (you should be able to perform deployments to AWS via Terraform)
3. Python3 installed

## Deployment
1. Set the Terraform variables in `terraform.tfvars`.
    ```hcl
    chat_id        = "<YOUR_CHAT_ID>"
    telegram_token = "<YOUR_TELEGRAM_TOKEN>"
    env            = "<YOUR_ENV>"
    region         = "<YOUR_REGION>"
    ```

    - `YOUR_TELEGRAM_TOKEN`
        - Copy from @BotFather's message when you first create the bot
        
    - `YOUR_CHAT_ID`
        - Add your bot to a group chat
        - Send `/start` in the chat
        - In your terminal, do 
            ```shell script
            curl https://api.telegram.org/bot<YOUR_TELEGRAM_TOKEN>/getUpdates
            ```
        - You should get a response like the following:
            ```json
            {
                "chat": {
                    "id": 123456789,
                    "title": "..."
                }
            }
            ```
        - Use `id` in `chat` as `YOUR_CHAT_ID`
    
    - `YOUR_ENV`
        - Set a name for your environment, else it will default to `prod`
        
    - `YOUR_REGION`
        - Set an AWS region you wish to deploy in

2. Run the following Terraform commands in your terminal, in the `serverless-telegram-bot/terraform` folder, to create the resources in AWS
    ```shell script
    terraform init && terraform apply
    ```
   You should see the following output at the end
    ```shell script
    Apply complete! Resources: 8 added, 0 changed, 0 destroyed.
    
    Outputs:
    
    webhook = https://<SOME_ID_GIVEN_BY_AWS>.execute-api.<YOUR_REGION>.amazonaws.com/<YOUR_ENV>/telegram-bot
    ```
   
3. Copy the `webhook` from the output in previous step and set up the Telegram bot's webhook.
    - In your terminal, do 
        ```shell script
        curl -X POST -H "content-type: application/json" -d '{"url": "https://<SOME_ID_GIVEN_BY_AWS>.execute-api.<YOUR_REGION>.amazonaws.com/<YOUR_ENV>/telegram-bot", "allowed_updates": ["message"]}' https://api.telegram.org/bot<YOUR_TELEGRAM_TOKEN>/setWebhook
        ```
   
4. Add your commands for the bot via @BotFather and start sending messages in the group chat prefixed with those commands
    - Send `/mybots` to @BotFather
    - Click on your bot
    - Click on `Edit Bot`
    - Click on `Edit Commands`
    
## Tearing down
1. Run the following Terraform commands in your terminal, in the `serverless-telegram-bot/terraform` folder, to destroy the resources in AWS
    ```shell script
    terraform destroy
    ```
   
2. Delete the bot via @BotFather
