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

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

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

{% include [api-response-200](../../../_includes/postbox/api-response-200.md) %}

### Ошибки {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

Возможные ошибки:

#|
|| **Код ошибки** | **Описание** ||
|| `400 BadRequestException` | В запросе неправильно указаны заголовки или параметры. ||
|| `404 NotFoundException` | Запрошенный ресурс не найден. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#