# Метод DeleteSuppressedDestination

Удаляет адрес из [пользовательского стоп-листа](../../concepts/suppression-list.md#user). Нужное облако определяется по сервисному аккаунту, от имени которого выполняется запрос.

## Запрос {#request}

```http
DELETE /v2/email/suppression/addresses/{EmailAddress} HTTP/2
```

### Path-параметры {#path-parameters}

#|
|| **Параметр** | **Описание** ||
|| `EmailAddress` | **Тип**: string.

Адрес получателя, который нужно удалить из стоп-листа. Должен быть в процентном кодировании, например `user%40example.com`. ||
|#

### Заголовки запроса {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

## Ответы {#responses}

### 200 OK {#200}

{% include [api-response-200](../../../_includes/postbox/api-response-200.md) %}

Если указанного адреса нет в стоп-листе, запрос тоже завершается успешно.

### Ошибки {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

Возможные ошибки:

#|
|| **Код ошибки** | **Описание** ||
|| `400 BadRequestException` | В запросе указан пустой или некорректный адрес. ||
|| `403` | Недостаточно прав для выполнения запроса. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#
