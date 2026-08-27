# Метод PutSuppressedDestination

Добавляет адрес в [пользовательский стоп-лист](../../concepts/suppression-list.md#user). Нужное облако определяется по сервисному аккаунту, от имени которого выполняется запрос.

## Запрос {#request}

```http
PUT /v2/email/suppression/addresses HTTP/2
```

### Заголовки запроса {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

### Тело запроса {#request-body}

```json
{
   "EmailAddress": "user@example.com",
   "Reason": "BOUNCE|COMPLAINT"
}
```

#|
|| **Параметр** | **Описание** ||
|| `EmailAddress` | **Тип**: string.

Адрес получателя, который нужно добавить в стоп-лист. ||
|| `Reason` | **Тип**: string.

Обязательный параметр. [Причина](../../concepts/suppression-list.md#reasons) добавления адреса в стоп-лист: `BOUNCE` или `COMPLAINT`. ||
|#

Если адрес уже есть в стоп-листе, новая запись не создается: у текущей записи обновляются причина и время изменения, а время создания сохраняется.

## Ответы {#responses}

### 200 OK {#200}

{% include [api-response-200](../../../_includes/postbox/api-response-200.md) %}

### Ошибки {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

Возможные ошибки:

#|
|| **Код ошибки** | **Описание** ||
|| `400 BadRequestException` | В запросе указан пустой или некорректный адрес либо причина не указана или не равна `BOUNCE` или `COMPLAINT`. ||
|| `403` | Недостаточно прав для выполнения запроса. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#
