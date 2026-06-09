# Поддерживаемые инструменты

{% note info %}

Сервис находится на [стадии Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

Чтобы включить Cloud Notification Service, запросите доступ к сервису у вашего аккаунт-менеджера или в [технической поддержке](https://center.yandex.cloud/support).

Cloud Notification Service (CNS) — сервис для мультиканальной отправки уведомлений пользователям. HTTP API сервиса совместим с [Amazon SNS API](https://docs.aws.amazon.com/sns/latest/api/welcome.html).

На стадии Preview доступна отправка [push-уведомлений](../concepts/push.md) на устройства с iOS и Android, в браузеры и [SMS](../concepts/sms.md). Уведомления можно отправлять как в отдельные эндпоинты, так и в группы эндпоинтов через [топики](../concepts/topics.md).

Позднее будет реализована отправка уведомлений в мессенджеры.

С помощью Cloud Notification Service вы можете отправлять уведомления в приложения, зарегистрированные в следующих сервисах:

* [Apple Push Notification service](https://developer.apple.com/notifications/) (APNs).
* [Firebase Cloud Messaging](https://firebase.google.com/) (FCM).
* [Huawei Mobile Services](https://developer.huawei.com/consumer/) (HMS).
* [RuStore](https://www.rustore.ru/help/sdk/push-notifications/).

А также в браузеры пользователей на любом устройстве.

Вы можете использовать при работе с Cloud Notification Service не только инструменты Yandex Cloud, но и инструменты для работы с Amazon S3:

* [AWS CLI](aws-cli.md)
* [AWS SDK для C++](sdk-cpp.md)
* [AWS SDK для Go](sdk-go.md)
* [AWS SDK для Java](sdk-java.md)
* [AWS SDK для JavaScript](sdk-javascript.md)
* [AWS SDK для Kotlin](sdk-kotlin.md)
* [AWS SDK для .NET](sdk-dot-net.md)
* [AWS SDK для PHP](sdk-php.md)
* [AWS SDK для Python (boto3)](sdk-python.md)