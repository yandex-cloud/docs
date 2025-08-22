```bash
aws sns subscribe \
  --topic-arn <ARN_топика> \
  --protocol <тип_канала> \
  --notification-endpoint <ARN_эндпоинта_или_номер_телефона>
```

Где:
  * `topic-arn` — ARN топика.
  * `protocol` — тип канала отправки уведомлений, например, `sms`, `application`.
  * `notification-endpoint` — {% include [arn_or_number](arn_or_number.md) %}.

Подробнее о команде `aws sns subscribe` см. в [документации AWS](https://docs.amazonaws.cn/en_us/sns/latest/dg/sns-create-subscribe-endpoint-to-topic.html).