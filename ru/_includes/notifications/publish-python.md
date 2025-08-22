```python
try:
    response = client.publish(
        TopicArn="<ARN_топика>",
        Message=json.dumps({
            "default": "<текст_уведомления>",
            "APNS": {"aps":{"alert":"<текст_уведомления>"}},
            "GCM": {"notification":{"body":"<текст_уведомления>"}},
            "HMS": {"notification":{"body":"<текст_уведомления>"}},
            "RUSTORE": {"notification":{"body":"<текст_уведомления>"}},
            "WEB": "<текст_уведомления>",
            "sms": "<текст_уведомления>"
        }),
        MessageStructure="json"
    )
    print(f"Message ID: {response["MessageId"]}")
except botocore.exceptions.ClientError as error:
    print(f"Error: {error}")
```

Где:

* `TopicArn` — ARN топика.
* `Message` — текст уведомления. Можно указать единый текст для всех типов каналов или разные тексты для каждого типа канала. Если какой-либо канал не указан, будет отправлено сообщение по умолчанию из поля `default`.
* `MessageStructure` — формат сообщения (`json`).