```bash
aws sns subscribe \
  --topic-arn <ARN_топика> \
  --protocol <тип_канала> \
  --notification-endpoint <ARN_эндпоинта_или_номер_телефона>
```

Где:
  * `topic-arn` — ARN топика.
  * `protocol` — тип канала отправки уведомлений, например `sms`, `application`, `sqs`.
  * `notification-endpoint` — эндпоинт, который подписывается на топик:

    {% include [subscribe-endpoint-types](subscribe-endpoint-types.md) %}

      Чтобы топик мог отправлять сообщения в очередь, у него должен быть задан атрибут `SQSServiceAccountId`. Подробнее в инструкциях по [созданию](../../notifications/operations/topics/topic-create.md#aws-cli) и [управлению](../../notifications/operations/topics/topic-manage.md#aws-cli) топиком.

Подробнее о команде `aws sns subscribe` смотрите в [документации AWS](https://docs.amazonaws.cn/en_us/sns/latest/dg/sns-create-subscribe-endpoint-to-topic.html).