import json
import os
import requests

CHAT_ID = int(os.environ['CHAT_ID'])
TELEGRAM_TOKEN = os.environ['TELEGRAM_TOKEN']


def send_message(msg):
    url = f"https://api.telegram.org/bot{TELEGRAM_TOKEN}/sendMessage?text={msg}&chat_id={CHAT_ID}"
    return requests.get(url)


def lambda_handler(event, context):
    # Load the body string as JSON
    body = json.loads(event['body'])
    # Get the text from the body
    print(body['message']['text'])
    # Send a message back if you'd like!
    res = send_message("Hello from serverless!")
    print(res.json())
