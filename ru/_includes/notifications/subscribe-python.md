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
* `Endpoint` — ARN эндпоинта, который подписывается на топик, в формате `arn:aws:sns::<cloud_id>:endpoint/<platform>/<channel_name>/<endpoint_unique_id>`. Для SMS — номер телефона в формате [E.164](https://{{ lang }}.wikipedia.org/wiki/E.164), например `+79991112233`.