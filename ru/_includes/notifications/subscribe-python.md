```python
try:
    response = client.subscribe(
        TopicArn = "<ARN_топика>",
        Protocol = "<тип_канала>",
        Endpoint = "<ARN_эндпоинта_или_номер_телефона>"
    )
    print(f"Topic ARN: {response['TopicArn']}")
except botocore.exceptions.ClientError as error:
    print(f"Error: {error}")
```

Где:

* `TopicArn` — ARN топика.
* `Protocol` — тип канала для отправки уведомлений, например, `sms`, `application`.
* `Endpoint` — {% include [arn_or_number](arn_or_number.md) %}.