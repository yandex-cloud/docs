```bash
aws sns subscribe \
  --topic-arn <ARN_топика> \
  --protocol <тип_канала> \
  --notification-endpoint <ARN_эндпоинта_или_номер_телефона>
```

Где:
  * `topic-arn` — ARN топика.
  * `protocol` — тип канала отправки уведомлений, например, `sms`, `application`.
  * `notification-endpoint` — ARN эндпоинта, который подписывается на топик, в формате `arn:aws:sns::<cloud_id>:endpoint/<platform>/<channel_name>/<endpoint_unique_id>`. Для SMS — номер телефона в формате [E.164](https://{{ lang }}.wikipedia.org/wiki/E.164), например `+79991112233`.

Подробнее о команде `aws sns subscribe` см. в [документации AWS](https://docs.amazonaws.cn/en_us/sns/latest/dg/sns-create-subscribe-endpoint-to-topic.html).