```python
try:
    response = client.subscribe(
        TopicArn = "<ARN_топика>",
        Protocol = "<тип_канала>",
        Endpoint = "<ARN_эндпоинта_или_номер_телефона_или_URL_очереди>"
    )
    print(f"Topic ARN: {response['TopicArn']}")
except botocore.exceptions.ClientError as error:
    print(f"Error: {error}")
```

Где:

* `TopicArn` — ARN топика.
* `Protocol` — тип канала для отправки уведомлений, например `sms`, `application`, `sqs`.
* `Endpoint` — эндпоинт, который подписывается на топик:

    {% include [subscribe-endpoint-types](subscribe-endpoint-types.md) %}

	Чтобы топик мог отправлять сообщения в очередь, у него должен быть задан атрибут `SQSServiceAccountId`. Подробнее в инструкциях по [созданию](../../notifications/operations/topics/topic-create.md#python) и [управлению](../../notifications/operations/topics/topic-manage.md#python) топиком.
