# Метод GetDomainIdentity

Возвращает информацию об [адресе](../../concepts/glossary.md#adress) в каталоге. Нужный каталог определяется по сервисному аккаунту, от имени которого выполняется запрос.

## Запрос {#request}

```http
GET /v2/email/identities/{DomainIdentity} HTTP/2
```

### Path-параметры {#path-parameters}

#|
|| **Параметр** | **Описание** ||
|| `DomainIdentity` | **Тип**: string.

Адрес, о котором запрашивается информация. Минимальная длина — один символ. ||
|#

### Заголовки запроса {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

## Ответы {#responses}

### 200 OK {#200}

```json
{
  "IdentityType": "<тип_адреса>",
  "FeedbackForwardingStatus": <статус_уведомлений_о_неполадках>,
  "VerifiedForSendingStatus": <статус_верификации_для_отправки_писем>,
  "DkimAttributes": {
    "SigningEnabled": <использование_DKIM>,
    "Status": "<статус_поиска_DKIM>",
    "Tokens": [
      "<селектор_для_открытого_ключа>"
    ],
    "SigningAttributesOrigin": "<способ_конфигурации_DKIM>",
    "NextSigningKeyLength": "<параметр_для_совместимости>",
    "CurrentSigningKeyLength": "<параметр_для_совместимости>"
  },
  "Tags": [
    {
      "Key": "<ключ_метки>",
      "Value": "<значение_метки>"
    }
  ],
  "ConfigurationSetName": "<название_конфигурации>",
  "VerificationStatus": "<статус_верификации_адреса>"
}
```

#|
|| **Параметр** | **Описание** ||
|| `IdentityType` | **Тип**: string.

Тип адреса. Значение — `DOMAIN`. ||
|| `FeedbackForwardingStatus` | **Тип**: boolean.

Возможные значения: `true` или `false`. Если указано значение `true`, вы будете получать уведомления в случае неполадок с доставкой и отправкой писем. ||
|| `VerifiedForSendingStatus` | **Тип**: boolean.

Указывает, можно ли отправлять электронную почту с этого адреса. Возможные значения: `true` или `false`.
Чтобы отправлять почту, адрес необходимо верифицировать. ||
|| `DkimAttributes` | **Тип**: object.

Объект, который содержит параметры DKIM-подписи. ||
|| `SigningEnabled` | **Тип**: boolean.

Указывает, используется ли DKIM-подпись при отправке электронной почты с этого адреса. Возможные значения: `true` или `false`. ||
|| `Status` | **Тип**: string.

Указывает, удалось ли {{ postbox-name }} обнаружить DKIM-подпись в DNS-конфигурации адреса. Возможные значения:
  * `PENDING` — поиск запущен, но сервис пока не обнаружил DKIM-подпись в DNS-конфигурации адреса.
  * `SUCCESS` — DKIM-подпись обнаружена.
  * `FAILED` — не удалось обнаружить DKIM-подпись.
  * `TEMPORARY_FAILURE` — из-за временной проблемы {{ postbox-name }} не может обнаружить DKIM-подпись.
  * `NOT_STARTED` — поиск не был запущен. ||
|| `Tokens` | **Тип**: array.
  
Список селекторов для идентификации открытого ключа. Тип для селектора: string. ||
|| `SigningAttributesOrigin` | **Тип**: string.

Указывает, как была настроена DKIM-подпись. Значение `EXTERNAL` говорит о том, что  DKIM-подпись настроена с помощью BYODKIM. ||
|| `NextSigningKeyLength` | **Тип**: string.

Используется только для совместимости с AWS. ||
|| `CurrentSigningKeyLength` | **Тип**: string.

Используется только для совместимости с AWS. ||
|| `Tags` | **Тип**: array.

Массив меток для адреса. ||
|| `ConfigurationSetName` | **Тип**: string.

Название конфигурации. ||
|| `VerificationStatus` | **Тип**: string.

Статус верификации:
  * `PENDING` — верификация была запущена, но в {{ postbox-name }} пока не удалось подтвердить адрес.
  * `SUCCESS` — верификация успешно завершена.
  * `FAILED` — не удалось выполнить верификацию.
  * `TEMPORARY_FAILURE` — из-за временной проблемы {{ postbox-name }} не может определить статус верификации.
  * `NOT_STARTED` — верификация не была запущена. ||
|#

### Ошибки {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

Возможные ошибки:

#|
|| **Код ошибки** | **Описание** ||
|| `400 BadRequestException` | В запросе неправильно указаны заголовки или параметры. ||
|| `404 NotFoundException` | Запрошенный ресурс не найден. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#