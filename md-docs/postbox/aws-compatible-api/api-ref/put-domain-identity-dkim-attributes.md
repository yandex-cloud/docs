[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Postbox](../../index.md) > [Справочник API](../index.md) > [REST](index.md) > Адреса > Метод PutDomainIdentityDkimAttributes

# Метод PutDomainIdentityDkimAttributes

Включает или отключает [DKIM-подпись](https://ru.wikipedia.org/wiki/DomainKeys_Identified_Mail) для [адреса](../../concepts/glossary.md#adress). Позволяет получателю убедиться, что письмо действительно было отправлено с заявленного домена. Применяется для борьбы с фишинговыми письмами и спамом.

## Запрос {#request}

```http
PUT /v2/email/identities/{DomainIdentity}/dkim HTTP/2
```

### Path-параметры {#path-parameters}

#|
|| **Параметр** | **Описание** ||
|| `DomainIdentity` | **Тип**: string.

Адрес, для которого будет включена или отключена DKIM-аутентификация. Минимальная длина — один символ. ||
|#

### Заголовки запроса {#request-headers}

Используйте в запросе [общие заголовки](request-headers.md).

### Тело запроса {#request-body}

```json
{
  "SigningEnabled": <использование_DKIM>
}
```

#|
|| **Параметр** | **Описание** ||
|| `SigningEnabled` | **Тип**: boolean.

Включает или отключает использование DKIM-подписи при отправке почты с этого адреса. Возможные значения: `true` или `false`. ||
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
|| `400 BadRequestException` | В запросе неправильно указаны заголовки или параметры. ||
|| `404 NotFoundException` | Запрошенный ресурс не найден. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#