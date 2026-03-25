# Обзор HTTP API {{ cns-full-name }}

HTTP API сервиса {{ cns-name }} совместим с [Amazon SNS API](https://docs.aws.amazon.com/sns/latest/api/welcome.html). 

Для более удобного взаимодействия с сервисом поддержана работа с [AWS CLI](../tools/aws-cli.md), [AWS SDK для Python (boto3)](../tools/sdk-python.md) и другими [AWS-совместимыми SDK](../tools/).

Для аутентификации в API, CLI и SDK используется [статический ключ доступа](../../iam/concepts/authorization/access-key.md). Статический ключ доступа выпускается на [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), и все действия выполняются от имени этого сервисного аккаунта.

{% note info %}

Запросы API к {{ cns-name }} со статическим ключом должны быть подписаны по алгоритму [AWS Signature V4](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html).

{% endnote %}

Чтобы не подписывать запросы API к {{ cns-name }}, вместо статического ключа вы можете использовать [IAM-токен](../../iam/concepts/authorization/iam-token.md). Подробнее см. [{#T}](send-request.md).

Перечень общих кодов ошибок для всех действий см. в разделе [{#T}](common-errors.md).

## Поддерживаемые действия {#actions}

### PlatformApplications {#platform-applications}

| Действие | Описание |
| --- | --- |
| [Create](create-platform-application.md) | Создать [канал мобильных push-уведомлений](../concepts/push.md). |
| [GetAttributes](get-platform-application-attributes.md) | Получить параметры канала мобильных push-уведомлений. |
| [SetAttributes](set-platform-application-attributes.md) | Задать параметры канала мобильных push-уведомлений. |
| [List](list-platform-applications.md) | Получить список каналов мобильных push-уведомлений. |
| [Delete](delete-platform-application.md) | Удалить канал мобильных push-уведомлений. |

### Endpoint {#endpoint}

| Действие | Описание |
| --- | --- |
| [Create](create-platform-endpoint.md) | Создать [эндпоинт для push-уведомлений](../concepts/index.md#mobile-endpoints) (подписать пользователя на push-уведомления). |
| [GetAttributes](get-endpoint-attributes.md) | Получить параметры эндпоинта. |
| [SetAttributes](set-endpoint-attributes.md) | Задать параметры эндпоинта. |
| [List](list-endpoints.md) | Получить список эндпоинтов. |
| [Delete](delete-endpoint.md) | Удалить эндпоинт (отписать пользователя от push-уведомлений).  |

### SMS {#sms}

| Действие | Описание |
| --- | --- |
| [Create](create-sms-channel.md) | Создать [канал SMS-уведомлений](../concepts/sms.md). |
| [GetAttributes](get-sms-channel-attributes.md) | Получить параметры канала SMS-уведомлений. |
| [GetSmsAttributes](get-sms-attributes.md) | Получить параметры для отправки SMS-уведомлений в облаке. |
| [SetAttributes](set-sms-channel-attributes.md) | Задать параметры канала SMS-уведомлений. |
| [List](list-sms-channels.md) | Получить список каналов SMS-уведомлений. |
| [Delete](delete-sms-channel.md) | Удалить канал SMS-уведомлений. |

### Sandbox {#sandbox}

| Действие | Описание |
| --- | --- |
| [Create](create-sms-sandbox-phone-number.md) | Добавить [тестовый номер](../concepts/sms.md#sandbox) в канал SMS-уведомлений и отправить на номер одноразовый пароль. |
| [Verify](verify-sms-sandbox-phone-number.md) | Подтвердить номер с помощью одноразового пароля. |
| [List](list-sms-sandbox-phone-numbers.md) | Получить список подтвержденных номеров. |
| [Delete](delete-sms-sandbox-phone-number.md) | Удалить подтвержденный номер. |

### Publish {#publish}

| Действие | Описание |
| --- | --- |
| [Publish](publish.md) | Отправить push-уведомление или SMS. |
