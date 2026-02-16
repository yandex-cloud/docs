# Метод DeleteConfigurationSetEventDestination

Удаляет [подписку](../../concepts/glossary.md#subscription) для [конфигурации](../../concepts/glossary.md#configuration) в каталоге. Нужный каталог определяется по сервисному аккаунту, от имени которого выполняется запрос.

## Запрос {#request}

```http
DELETE /v2/email/configuration-sets/{ConfigurationSetName}/event-destinations/{EventDestinationName} HTTP/2
```

### Path-параметры {#path-parameters}

#|
|| **Параметр** | **Описание** ||
|| `ConfigurationSetName` | **Тип**: string.

Название конфигурации. ||
|| `EventDestinationName` | **Тип**: string.

Название подписки, которая будет удалена. ||
|#

### Заголовки запроса {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

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