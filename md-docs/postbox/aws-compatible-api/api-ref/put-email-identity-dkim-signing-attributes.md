[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Postbox](../../index.md) > [Справочник API](../index.md) > [REST](index.md) > Адреса > Метод PutEmailIdentityDkimSigningAttributes

# Метод PutEmailIdentityDkimSigningAttributes

Перепроверяет [DKIM-подпись](../../concepts/glossary.md#dkim) [адреса](../../concepts/glossary.md#address) в каталоге и возвращает ее статус. Нужный каталог определяется по сервисному аккаунту, от имени которого выполняется запрос.

{% note warning %}

В Yandex Cloud Postbox метод работает не так, как в Amazon SES: он не изменяет настройки DKIM-подписи, а только синхронно проверяет DNS-записи DKIM. Изменить способ настройки DKIM-подписи или ее параметры с помощью метода нельзя.

{% endnote %}

## Запрос {#request}

```http
PUT /v2/email/identities/{EmailIdentity}/dkim/signing HTTP/2
```

### Path-параметры {#path-parameters}

#|
|| **Параметр** | **Описание** ||
|| `EmailIdentity` | **Тип**: string.

Адрес, DKIM-подпись которого нужно перепроверить. ||
|#

### Заголовки запроса {#request-headers}

Используйте в запросе [общие заголовки](request-headers.md).

### Тело запроса {#request-body}

```json
{
  "SigningAttributesOrigin": "AWS_SES|EXTERNAL"
}
```

#|
|| **Параметр** | **Описание** ||
|| `SigningAttributesOrigin` | **Тип**: string.

Способ настройки DKIM-подписи адреса. Возможные значения:

* `AWS_SES` — простая настройка (Easy DKIM).
* `EXTERNAL` — расширенная настройка (BYODKIM).

Значение должно совпадать с текущим способом настройки DKIM-подписи адреса. Его можно узнать в поле `SigningAttributesOrigin` ответа метода [GetDomainIdentity](get-domain-identity.md).

Обязательный параметр. ||
|#

Параметр `SigningAttributes` не поддерживается. Если передать его в запросе, метод вернет ошибку `400 BadRequestException`.

## Ответы {#responses}

### 200 OK {#200}

```json
{
  "DkimStatus": "<статус_DKIM>",
  "DkimTokens": [
    "<селектор_для_открытого_ключа>"
  ]
}
```

#|
|| **Параметр** | **Описание** ||
|| `DkimStatus` | **Тип**: string.

Результат проверки DKIM-подписи в DNS-конфигурации адреса. Возможные значения:

* `PENDING` — поиск запущен, но сервис пока не обнаружил DKIM-подпись в DNS-конфигурации адреса.
* `SUCCESS` — DKIM-подпись обнаружена.
* `FAILED` — не удалось обнаружить DKIM-подпись.
* `TEMPORARY_FAILURE` — из-за временной проблемы Yandex Cloud Postbox не может обнаружить DKIM-подпись.
* `NOT_STARTED` — поиск не был запущен. ||
|| `DkimTokens` | **Тип**: array.

Список селекторов для идентификации открытого ключа. Тип для селектора: string. ||
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
|| `400 BadRequestException` | В запросе неправильно указаны заголовки или параметры. Также возвращается, если передан параметр `SigningAttributes` или значение `SigningAttributesOrigin` не совпадает с текущим способом настройки DKIM-подписи адреса. ||
|| `404 NotFoundException` | Адрес не найден. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#