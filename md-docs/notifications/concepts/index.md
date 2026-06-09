# Обзор Yandex Cloud Notification Service

Cloud Notification Service (CNS) — сервис для мультиканальной отправки уведомлений пользователям. HTTP API сервиса совместим с [Amazon SNS API](https://docs.aws.amazon.com/sns/latest/api/welcome.html).

{% note info %}

Сервис находится на [стадии Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

Чтобы включить Cloud Notification Service, запросите доступ к сервису у вашего аккаунт-менеджера или в [технической поддержке](https://center.yandex.cloud/support).

Благодаря совместимости с Amazon SNS API для работы с сервисом вы можете использовать существующие инструменты, например [AWS CLI](../tools/aws-cli.md) и AWS SDK.

## Каналы уведомлений {#channels}

В Cloud Notification Service сообщения конечным пользователям отправляются через _каналы уведомлений_.

На стадии Preview доступна отправка [push-уведомлений](push.md) на устройства с iOS и Android, в браузеры и [SMS](sms.md). Уведомления можно отправлять как в отдельные эндпоинты, так и в группы эндпоинтов через [топики](topics.md).

Позднее будет реализована отправка уведомлений в мессенджеры.

## См. также {#see-also}

* [Как начать работать c сервисом](../quickstart.md)
* [Как начать работать с сервисом с помощью AWS CLI](../tools/aws-cli.md)
* [Квоты и лимиты](limits.md)