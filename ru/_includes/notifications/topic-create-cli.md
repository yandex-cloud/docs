```bash
aws sns create-topic \
  --name <имя_топика> \
  --attributes "{\"SQSServiceAccountId\":\"<идентификатор_сервисного_аккаунта>\"}"
```

Где:

* `name` — произвольное имя топика, должно быть уникальным в {{ cns-name }}.

{% include [sqs-service-account-attribute](sqs-service-account-attribute.md) %}

Подробнее о команде `aws sns create-topic` смотрите в [документации AWS](https://docs.amazonaws.cn/en_us/sns/latest/dg/sns-create-topic.html).
