```python
try:
    response = client.publish(
        TopicArn="<topic_ARN>",
        Message=json.dumps({
            "default": "<notification_text>",
            "APNS": {"aps":{"alert":"<notification_text>"}},
            "GCM": {"notification":{"body":"<notification_text>"}},
            "HMS": {"notification":{"body":"<notification_text>"}},
            "RUSTORE": {"notification":{"body":"<notification_text>"}},
            "WEB": "<notification_text>",
            "sms": "<notification_text>"
        }),
        MessageStructure="json"
    )
    print(f"Message ID: {response["MessageId"]}")
except botocore.exceptions.ClientError as error:
    print(f"Error: {error}")
```

Where:

* `TopicArn`: Topic ARN.
* `Message`: Notification text. You can add the same text for all channel types or different texts for each channel type. If a channel is not specified, the notification will contain the `default` message text.
* `MessageStructure`: Message format (`json`).