# Метод UpdateConfigurationSetEventDestination

Обновляет [подписку](../../concepts/glossary.md#subscription) для [конфигурации](../../concepts/glossary.md#configuration) в каталоге. Нужный каталог определяется по сервисному аккаунту, от имени которого выполняется запрос.

## Запрос {#request}

```http
PUT /v2/email/configuration-sets/{ConfigurationSetName}/event-destinations/{EventDestinationName} HTTP/2
```

### Path-параметры {#path-parameters}

#|
|| **Параметр** | **Описание** ||
|| `ConfigurationSetName` | **Тип**: string.

Название конфигурации. ||
|| `EventDestinationName` | **Тип**: string.

Название подписки, которая будет изменена.
|#

### Заголовки запроса {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

### Тело запроса {#request-body}

```json
{
  "EventDestination": {
    "Enabled": <состояние_подписки>,
    "KinesisFirehoseDestination": {
      "IamRoleArn": "<параметр_для_совместимости>",
      "DeliveryStreamArn": "<поток данных>"
    }
  }
}
```

#|
|| **Параметр** | **Описание** ||
|| `EventDestination` | **Тип**: объект.

Объект, который содержит параметры подписки. ||
|| `Enabled` | **Тип**: boolean.

Состояние подписки: `true` — включена, `false` — выключена. Если подписка включена, в указанный поток отправляются уведомления о доставке писем. ||
|| `KinesisFirehoseDestination` | **Тип**: object.

Объект, который определяет место назначения для отправки уведомлений. ||
|| `IamRoleArn` | **Тип**: string.

Используется только для совместимости с AWS. ||
|| `DeliveryStreamArn` | **Тип**: string.

Поток данных {{ yds-full-name }}, в который отправляются уведомления.

Формат: `arn:yc:yds:<регион>::<эндпоинт>:<название потока>`. Эндпоинт можно скопировать из поля **{{ ui-key.yacloud.ydb.overview.label_kinesis-endpoint }}** нужного потока в {{ yds-name }}.

{% cut "Пример" %}

`arn:yc:yds:ru-central1::https://yds.serverless.yandexcloud.net/ru-central1/b1gkgm9daf9605nj****/etn5nuveugdr18ak****:postbox`

{% endcut %} ||
|#

## Ответы {#responses}

### 200 OK {#200}

{% include [api-response-200](../../../_includes/postbox/api-response-200.md) %}

### Ошибки {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

Возможные ошибки:

#|
|| **Код ошибки** | **Описание** ||
|| `400 BadRequestException` | В запросе неправильно указаны заголовки или параметры. ||
|| `404 NotFoundException` | Запрошенный ресурс не найден. ||
|| `429 TooManyRequestsException ` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#