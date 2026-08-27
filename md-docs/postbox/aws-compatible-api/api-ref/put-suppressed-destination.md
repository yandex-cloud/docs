[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Postbox](../../index.md) > [Справочник API](../index.md) > [REST](index.md) > Стоп-лист > Метод PutSuppressedDestination

# Метод PutSuppressedDestination

Добавляет адрес в [пользовательский стоп-лист](../../concepts/suppression-list.md#user). Нужное облако определяется по сервисному аккаунту, от имени которого выполняется запрос.

## Запрос {#request}

```http
PUT /v2/email/suppression/addresses HTTP/2
```

### Заголовки запроса {#request-headers}

Используйте в запросе [общие заголовки](request-headers.md).

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
|| `400 BadRequestException` | В запросе указан пустой или некорректный адрес либо причина не указана или не равна `BOUNCE` или `COMPLAINT`. ||
|| `403` | Недостаточно прав для выполнения запроса. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#