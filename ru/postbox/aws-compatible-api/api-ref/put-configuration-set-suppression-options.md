# Метод PutConfigurationSetSuppressionOptions

Обновляет настройки [стоп-листа](../../concepts/suppression-list.md) для [конфигурации](../../concepts/glossary.md#configuration) в каталоге. Нужный каталог определяется по сервисному аккаунту, от имени которого выполняется запрос.

## Запрос {#request}

```http
PUT /v2/email/configuration-sets/{ConfigurationSetName}/suppression-options HTTP/2
```

### Path-параметры {#path-parameters}

#|
|| **Параметр** | **Описание** ||
|| `ConfigurationSetName` | **Тип**: string.

Название конфигурации, которая будет изменена. ||
|#

### Заголовки запроса {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

### Тело запроса {#request-body}

```json
{
   "SuppressedReasons": ["BOUNCE", "COMPLAINT"]
}
```

#|
|| **Параметр** | **Описание** ||
|| `SuppressedReasons` | **Тип**: array.

[Причины](../../concepts/suppression-list.md#reasons), по которым адрес из стоп-листа блокирует отправку письма. Допустимые значения элементов массива — `BOUNCE` и `COMPLAINT`.

Если массив содержит значение `COMPLAINT`, адреса автоматически добавляются в стоп-лист по жалобам получателей.

Если массив пустой, стоп-лист не блокирует отправку писем, а адреса не добавляются в него автоматически. ||
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
|| `403` | Недостаточно прав для выполнения запроса. ||
|| `404 NotFoundException` | Запрошенный ресурс не найден. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#
