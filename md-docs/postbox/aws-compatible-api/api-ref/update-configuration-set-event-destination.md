[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Postbox](../../index.md) > [Справочник API](../index.md) > [REST](index.md) > Подписки > Метод UpdateConfigurationSetEventDestination

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

Название подписки, которая будет изменена. ||
|#

### Заголовки запроса {#request-headers}

Используйте в запросе [общие заголовки](request-headers.md).

### Тело запроса {#request-body}

```json
{
  "EventDestination": {
    "Enabled": <состояние_подписки>,
    "KinesisFirehoseDestination": {
      "IamRoleArn": "<параметр_для_совместимости>",
      "DeliveryStreamArn": "<поток данных>"
    },
    "MatchingEventTypes": [
      "<тип_события>"
    ]
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

Поток данных Yandex Data Streams, в который отправляются уведомления.

Формат: `arn:yc:yds:<регион>::<эндпоинт>:<название потока>`. Эндпоинт можно скопировать из поля **Kinesis API эндпоинт** нужного потока в Data Streams.

{% cut "Пример" %}

`arn:yc:yds:ru-central1::https://yds.serverless.yandexcloud.net/ru-central1/b1gkgm9daf9605nj****/etn5nuveugdr18ak****:postbox`

{% endcut %} ||
|| `MatchingEventTypes` | **Тип**: array.

Массив типов событий, для которых отправляются уведомления. Допустимые значения:

* `SEND` — письмо принято сервисом;
* `DELIVERY` — письмо доставлено;
* `BOUNCE` — письмо не доставлено;
* `SUBSCRIPTION` — получатель отписался от рассылки;
* `OPEN` — письмо открыто;
* `CLICK` — получатель перешел по ссылке в письме;
* `DELIVERY_DELAY` — доставка письма задерживается;
* `COMPLAINT` — получатель пожаловался на письмо;
* `RENDERING_FAILURE` — ошибка рендеринга письма.

Если параметр не указан или массив пустой, уведомления отправляются только для событий `SEND`, `DELIVERY` и `BOUNCE`.

Подробнее в разделе [Уведомления об операциях с письмами](../../concepts/notification.md). ||
|#

Метод заменяет параметры подписки целиком. Передавайте в запросе все параметры подписки, включая `Enabled` и `MatchingEventTypes`, даже если нужно изменить только один из них.

## Ответы {#responses}

### 200 OK {#200}

Ответ `200 OK` возвращается в случае успешного выполнения запроса.

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
|| `400 BadRequestException` | В запросе неправильно указаны заголовки или параметры. ||
|| `404 NotFoundException` | Запрошенный ресурс не найден. ||
|| `429 TooManyRequestsException ` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#