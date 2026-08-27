# Метод CreateConfigurationSet

Создает [конфигурацию](../../concepts/glossary.md#configuration) в каталоге. Нужный каталог определяется по сервисному аккаунту, от имени которого выполняется запрос.

## Запрос {#request}

```http
POST /v2/email/configuration-sets HTTP/2
```

### Заголовки запроса {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

### Тело запроса {#request-body}

```json
{
  "ConfigurationSetName": "<название_конфигурации>",
  "SuppressionOptions": {
    "SuppressedReasons": ["BOUNCE", "COMPLAINT"]
  },
  "Tags": [
    {
      "Key": "<ключ_метки>",
      "Value": "<значение_метки>"
    }
  ]
}
```

#|
|| **Параметр** | **Описание** ||
|| `ConfigurationSetName` | **Тип**: string.

Название конфигурации.  ||
|| `SuppressionOptions` | **Тип**: object.

Настройки [стоп-листа](../../concepts/suppression-list.md) для конфигурации. Содержит массив `SuppressedReasons`. ||
|| `SuppressedReasons` | **Тип**: array.

[Причины](../../concepts/suppression-list.md#reasons), по которым адрес из стоп-листа блокирует отправку письма. Возможные значения элементов массива: `BOUNCE` и `COMPLAINT`.

Если массив содержит значение `COMPLAINT`, адреса автоматически добавляются в стоп-лист по жалобам получателей. ||
|| `Tags` | **Тип**: array.

Массив меток для конфигурации.

Максимальное количество — 50 меток. ||
|| `Key` | **Тип**: string.

Ключ метки.

Минимальная длина ключевого слова — 1 символ, максимальная — 63 символа. ||
|| `Value` | **Тип**: string.

Значение метки.

Минимальная длина значения метки — 0 символов (значение отсутствует), максимальная — 256 символов. ||
|#

## Ответы {#responses}

### 200 OK {#200}

{% include [api-response-200](../../../_includes/postbox/api-response-200.md) %}

### Ошибки {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

Возможные ошибки:

#|
|| **Код ошибки** | **Описание** ||
|| `400 BadRequestException` | В запросе переданы неправильные заголовки или параметры. ||
|| `404 NotFoundException` | Не найден запрашиваемый ресурс. ||
|| `409 AlreadyExistsException` | Конфигурация с таким названием уже существует, выберите другое имя. ||
|| `409 ConcurrentModificationException` | Конфликт операций. Дождитесь завершения предыдущей операции и повторите запрос. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|| `429 LimitExceededException` | При вызове запроса превышен [лимит](../../concepts/limits.md). ||
|#
