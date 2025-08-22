Для отправки уведомления:

```bash
aws sns publish \
--topic-arn <ARN_топика> \
--message-structure json \
--message '{"default": "<текст_уведомления>","APNS": {"aps":{"alert":"<текст_уведомления>"}},"GCM": {"notification":{"body":"<текст_уведомления>"}},"HMS": {"notification":{"body":"<текст_уведомления>"}},"RUSTORE": {"notification":{"body":"<текст_уведомления>"}},"WEB": "<текст_уведомления>","sms": "<текст_уведомления>"}'
```

Где:
  * `topic-arn` — ARN топика.
  * `message-structure` — формат сообщения `json`.
  * `message` — текст уведомления или путь к файлу с уведомлением. Для отправки разных уведомлений в зависимости от типа канала укажите канал и текст уведомления. Если какой-либо канал не указан, будет отправлено сообщение по умолчанию.

Подробнее о команде `aws sns publish` см. в [документации AWS](https://docs.amazonaws.cn/en_us/sns/latest/dg/sns-publish-to-topic.html).