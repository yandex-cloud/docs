# Метод CreateConfigurationSetEventDestinations

Создает [подписку](../../concepts/glossary.md#subscription) для [конфигурации](../../concepts/glossary.md#configuration) в каталоге. Нужный каталог определяется по сервисному аккаунту, от имени которого выполняется запрос.

## Запрос {#request}

```http
POST /v2/email/configuration-sets/{ConfigurationSetName}/event-destinations HTTP/2
```

### Path-параметры {#path-parameters}

#|
|| **Параметр** | **Описание** ||
|| `ConfigurationSetName` | **Тип**: string.

Название конфигурации. ||
|#

### Заголовки запроса {#request-headers}

Используйте в запросе [общие заголовки](request-headers.md).

### Тело запроса {#request-body}

```json
{
  "EventDestinationName": "<название_подписки>",
  "EventDestination": {
    "Enabled": <состояние_подписки>,
    "KinesisFirehoseDestination": {
      "IamRoleArn": "<роль>",
      "DeliveryStreamArn": "<поток_данных>"
    }
  },
  "MatchingEventTypes": [ "string" ]
}
```

#|
|| **Параметр** | **Описание** ||
|| `EventDestinationName` | **Тип**: string.

Название подписки. ||
|| `EventDestinations` | **Тип**: object.

Объект, который содержит параметры подписки. ||
|| `Enabled` | **Тип**: boolean.

Состояние подписки: `true` — включена, `false` — выключена. Если подписка включена, в указанный поток отправляются уведомления о доставке писем. ||
|| `KinesisFirehoseDestination` | **Тип**: object.

Объект, который определяет место назначения для отправки уведомлений. ||
|| `IamRoleArn` | **Тип**: string.

Параметр не используется. Предназначен для совместимости с AWS. ||
|| `DeliveryStreamArn` | **Тип**: string.

Поток данных Yandex Data Streams, в который отправляются уведомления.

Формат: `arn:yc:yds:<регион>::<эндпоинт>:<название потока>`. Эндпоинт можно скопировать из поля **Kinesis API эндпоинт** нужного потока в Data Streams.

{% cut "Пример" %}

`arn:yc:yds:ru-central1::https://yds.serverless.yandexcloud.net/ru-central1/b1gkgm9daf9605nj****/etn5nuveugdr18ak****:postbox`

{% endcut %} ||
|| `MatchingEventTypes` | **Тип**: array.

Массив типов событий, для которых будет отправляться уведомление. Допустимые значения:
- `SEND` — письмо отправлено;
- `BOUNCE` — письмо не доставлено;
- `SUBSCRIPTION` — подписка на рассылку;
- `DELIVERY` — письмо доставлено;
- `DELIVERY_DELAY` — задержка доставки письма;
- `OPEN` — письмо открыто;
- `CLICK` — переход по ссылке в письме.
||
|#

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
|| `400 BadRequestException` | В запросе переданы неправильные заголовки или параметры. ||
|| `404 NotFoundException` | Не найден запрашиваемый ресурс. ||
|| `409 AlreadyExistsException` | Подписка с таким названием уже существует, выберите другие имя. ||
|| `409 ConcurrentModificationException` | Конфликт операций. Дождитесь завершения предыдущей операции и повторите запрос. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|| `429 LimitExceededException` | При вызове запроса превышен [лимит](../../concepts/limits.md). ||
|#