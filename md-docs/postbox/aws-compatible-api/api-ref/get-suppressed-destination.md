[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Postbox](../../index.md) > [Справочник API](../index.md) > [REST](index.md) > Стоп-лист > Метод GetSuppressedDestination

# Метод GetSuppressedDestination

Возвращает информацию об адресе в [пользовательском стоп-листе](../../concepts/suppression-list.md#user). Нужное облако определяется по сервисному аккаунту, от имени которого выполняется запрос.

## Запрос {#request}

```http
GET /v2/email/suppression/addresses/{EmailAddress} HTTP/2
```

### Path-параметры {#path-parameters}

#|
|| **Параметр** | **Описание** ||
|| `EmailAddress` | **Тип**: string.

Адрес получателя. Должен быть в процентном кодировании, например `user%40example.com`. ||
|#

### Заголовки запроса {#request-headers}

Используйте в запросе [общие заголовки](request-headers.md).

## Ответы {#responses}

### 200 OK {#200}

```json
{
   "SuppressedDestination": {
      "EmailAddress": "user@example.com",
      "Reason": "BOUNCE",
      "LastUpdateTime": 1586552585.000,
      "Attributes": {
         "MessageId": "0000018f-..."
      }
   }
}
```

#|
|| **Параметр** | **Описание** ||
|| `EmailAddress` | **Тип**: string.

Адрес получателя. ||
|| `Reason` | **Тип**: string.

Причина добавления адреса в стоп-лист: `BOUNCE` или `COMPLAINT`. ||
|| `LastUpdateTime` | **Тип**: number.

Время последнего изменения записи в секундах в формате Unix. ||
|| `Attributes` | **Тип**: object.

Возвращается, только если адрес попал в стоп-лист автоматически. Содержит поле `MessageId` — идентификатор письма, из-за которого адрес попал в стоп-лист. Для адресов, добавленных вручную, объект отсутствует. ||
|#

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
|| `400 BadRequestException` | В запросе указан пустой или некорректный адрес. ||
|| `403` | Недостаточно прав для выполнения запроса. ||
|| `404 NotFoundException` | Адреса нет в стоп-листе. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#