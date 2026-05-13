# Метод GetConfigurationSetEventDestinations

Возвращает информацию о [подписках](../../concepts/glossary.md#subscription) для [конфигурации](../../concepts/glossary.md#configuration) в каталоге. Нужный каталог определяется по сервисному аккаунту, от имени которого выполняется запрос.

## Запрос {#request}

```http
GET /v2/email/configuration-sets/{ConfigurationSetName}/event-destinations HTTP/2
```

### Path-параметры {#path-parameters}

#|
|| **Параметр** | **Описание** ||
|| `ConfigurationSetName` | **Тип**: string.

Название конфигурации. ||
|#

### Заголовки запроса {#request-headers}

Используйте в запросе [общие заголовки](request-headers.md).

## Ответы {#responses}

### 200 OK {#200}

```json
{
  "EventDestinations": [
    {
      "Name": "<название_подписки>",
      "Enabled": <состояние_подписки>,
      "KinesisFirehoseDestination": {
        "DeliveryStreamArn": "<поток_данных>"
      }
    }
  ]
}
```

#|
|| **Параметр** | **Описание** ||
|| `EventDestinations` | **Тип**: array.

Массив подписок. ||
|| `Name` | **Тип**: string.

Название подписки. ||
|| `Enabled` | **Тип**: boolean.

Состояние подписки: `true` — включена, `false` — выключена. Если подписка включена, в указанный поток отправляются уведомления о доставке писем. ||
|| `KinesisFirehoseDestination` | **Тип**: object.

Объект, который определяет место назначения для отправки уведомлений. ||
|| `DeliveryStreamArn` | **Тип**: string.

Поток данных Yandex Data Streams, в который отправляются уведомления.

Формат: `arn:yc:yds:<регион>::<эндпоинт>:<название потока>`.

{% cut "Пример" %}

`arn:yc:yds:ru-central1::https://yds.serverless.yandexcloud.net/ru-central1/b1gkgm9daf9605nj****/etn5nuveugdr18ak****:postbox`

{% endcut %} ||
|#

Ответ `200 OK` может содержать дополнительные параметры. Он не возвращается строго в формате, указанном выше.

### Ошибки {#errors}

Для всех ошибок тело ответа представлено в одинаковом формате:

```json
{
   "Code": "<название_ошибки>",
   "message": "<пояснение_к_ошибке>"
}
```

Название ошибки заимствуется из ее кода, например `BadRequestException`.

Возможные ошибки:

#|
|| **Код ошибки** | **Описание** ||
|| `400 BadRequestException` | В запросе переданы неправильные заголовки или параметры. ||
|| `404 NotFoundException` | Не найден запрашиваемый ресурс. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#