```bash
aws sns create-platform-endpoint \
  --platform-application-arn <ARN_канала_уведомлений> \
  --token <Push-токен>
```

Где:

* `--platform-application-arn` — идентификатор (ARN) канала уведомлений.
* `--token` — уникальный Push-токен приложения на устройстве пользователя.

В результате вы получите идентификатор (ARN) мобильного эндпоинта. Сохраните его для дальнейшего использования.

Подробнее о команде `aws sns create-platform-endpoint` см. в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/create-platform-endpoint.html).