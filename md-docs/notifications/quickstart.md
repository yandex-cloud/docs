# Как начать работать с Yandex Cloud Notification Service

{% note info %}

Сервис находится на [стадии Preview](../overview/concepts/launch-stages.md).

{% endnote %}

Чтобы включить Cloud Notification Service, запросите доступ к сервису у вашего аккаунт-менеджера или в [технической поддержке](https://center.yandex.cloud/support).

Cloud Notification Service (CNS) — сервис для мультиканальной отправки уведомлений пользователям. HTTP API сервиса совместим с [Amazon SNS API](https://docs.aws.amazon.com/sns/latest/api/welcome.html).

На стадии Preview доступна отправка [push-уведомлений](concepts/push.md) на устройства с iOS и Android, в браузеры и [SMS](concepts/sms.md). Уведомления можно отправлять как в отдельные эндпоинты, так и в группы эндпоинтов через [топики](concepts/topics.md).

Позднее будет реализована отправка уведомлений в мессенджеры.

Начните работу с [push-уведомлениями](quickstart-push.md) или [SMS](quickstart-sms.md).

## См. также {#see-also}

* [Как начать работать с сервисом с помощью AWS CLI](tools/aws-cli.md)
* [Обзор сервиса](concepts/index.md)
* [Квоты и лимиты](concepts/limits.md)