# Уведомления об операциях с письмами

Чтобы получать уведомления об операциях с письмами, необходимо [создать конфигурацию](../operations/create-configuration.md) и [привязать ее к адресу](../operations/bind-configuration.md).

## Типы уведомлений {#types}

### Уведомление о приеме письма сервисом {#send}

Приходит, когда {{ postbox-name }} принял письмо в обработку.

Пример уведомления:

```json
{
    "eventType": "Send",
    "mail": {
        "timestamp": "2024-04-25T18:05:04.84108+03:00",
        "messageId": "vgAyRUls8591ybPKeH-Ov",
        "identityId": "nWh0ZpVEgnKO1bghxydXn",
        "commonHeaders": {
            "from":[ "User <user@example.com>" ],
            "date":"Thu, 27 Jun 2024 14:05:45 +0000",
            "to":[ "Recipient Name <recipient@example.com>" ],
            "messageId":"vgAyRUls8591ybPKeH-Ov",
            "subject":"Message sent using Yandex Cloud Postbox"
        },
        "headers": [
            { "name": "From", "value": "User <user@example.com>" },
            { "name": "To", "value": "Recipient Name <recipient@example.com>" },
            { "name": "Subject", "value": "Message sent using Yandex Cloud Postbox" },
            { "name": "Date", "value": "Thu, 27 Jun 2024 14:05:45 +0000" },
            { "name": "Content-Type", "value": "text/plain; charset=UTF-8" },
            { "name": "X-Campaign-Id", "value": "summer-sale-2024" }
        ],
        "tags": {
            "ses:configuration-set": [
                "kXVCt2Vd4dvm3MDvpc5Ml"
            ],
            "ses:from-domain": [
                "example.com"
            ],
            "ses:source-ip": [
               "123.123.123.123"
            ],
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ]
        }
    },
    "send": {  },
    "eventId": "vgAyRUls8591ybPKeH-Ov:0"
}
```

### Уведомление об ошибке рендеринга письма {#rendering-failure}

Приходит, когда {{ postbox-name }} принял письмо в обработку, но позже при рендеринге шаблона возникла ошибка.

Пример уведомления:

```json
{
    "eventType": "Rendering Failure",
    "mail": {
        "timestamp": "2024-04-25T18:05:04.84108+03:00",
        "messageId": "vgAyRUls8591ybPKeH-Ov",
        "identityId": "nWh0ZpVEgnKO1bghxydXn",
        "commonHeaders": {
            "from":[ "User <user@example.com>" ],
            "date":"Thu, 27 Jun 2024 14:05:45 +0000",
            "to":[ "Recipient Name <recipient@example.com>" ],
            "messageId":"vgAyRUls8591ybPKeH-Ov",
            "subject":"Message sent using Yandex Cloud Postbox"
        },
        "headers": [
            { "name": "From", "value": "User <user@example.com>" },
            { "name": "To", "value": "Recipient Name <recipient@example.com>" },
            { "name": "Subject", "value": "Message sent using Yandex Cloud Postbox" },
            { "name": "Date", "value": "Thu, 27 Jun 2024 14:05:45 +0000" },
            { "name": "Content-Type", "value": "text/plain; charset=UTF-8" },
            { "name": "X-Campaign-Id", "value": "summer-sale-2024" }
        ],
        "tags": {
            "ses:configuration-set": [
                "kXVCt2Vd4dvm3MDvpc5Ml"
            ],
            "ses:from-domain": [
                "example.com"
            ],
            "ses:source-ip": [
               "123.123.123.123"
            ],
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ]
        }
    },
    "failure": {
        "errorMessage": "template variable not_var{{name}} is missing"
    },
    "eventId": "vgAyRUls8591ybPKeH-Ov:0"
}
```

### Уведомление о доставке письма {#delivery}

Приходит, когда получателю отправили письмо и его почтовый клиент подтвердил прием письма.

Пример уведомления:

```json
{
    "eventType": "Delivery",
    "mail": {
        "timestamp": "2024-04-25T18:05:04.84108+03:00",
        "messageId": "vgAyRUls8591ybPKeH-Ov",
        "identityId": "nWh0ZpVEgnKO1bghxydXn",
        "commonHeaders": {
            "from":[ "User <user@example.com>" ],
            "date":"Thu, 27 Jun 2024 14:05:45 +0000",
            "to":[ "Recipient Name <recipient@example.com>" ],
            "messageId":"vgAyRUls8591ybPKeH-Ov",
            "subject":"Message sent using Yandex Cloud Postbox"
        },
        "headers": [
            { "name": "From", "value": "User <user@example.com>" },
            { "name": "To", "value": "Recipient Name <recipient@example.com>" },
            { "name": "Subject", "value": "Message sent using Yandex Cloud Postbox" },
            { "name": "Date", "value": "Thu, 27 Jun 2024 14:05:45 +0000" },
            { "name": "Content-Type", "value": "text/plain; charset=UTF-8" },
            { "name": "X-Campaign-Id", "value": "summer-sale-2024" }
        ],
        "tags": {
            "ses:configuration-set": [
               "kXVCt2Vd4dvm3MDvpc5Ml"
            ],
            "ses:from-domain": [
                "example.com"
            ],
            "ses:source-ip": [
                "123.123.123.123"
            ],
            "ses:outgoing-tls-cipher": [
                "AES_128_GCM_SHA256"
            ],
            "ses:outgoing-tls-version": [
                "TLSv1.3"
            ],
            "ses:outgoing-ip": [
                "51.250.56.125"
            ],
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ]
        }
    },
    "delivery": {
        "timestamp": "2024-04-25T18:05:14.84107+03:00",
        "processingTimeMillis": 9999,
        "recipients": [
            "abc@example.com"
        ]
    },
    "eventId": "ce3uqnS9pzQBMsnaAbrT_:0"
}
```

### Уведомление о том, что письмо не доставлено {#bounce}

Приходит, когда почтовый сервер получателя на попытку доставки отвечает ошибкой, которую {{ postbox-name }} считает не требующей повторной попытки доставки, или адрес получателя находится в одном из [стоп-листов](suppression-list.md).

Пример уведомления:

```json
{
    "eventType": "Bounce",
    "mail": {
        "timestamp": "2024-04-25T18:08:04.933666+03:00",
        "messageId": "QA_JPkU2fkpIWdkxAOASH",
        "identityId": "ZtYk0rrjN87m-Ovxjte1G",
        "commonHeaders": {
            "from":[ "User <user@example.com>" ],
            "date":"Thu, 27 Jun 2024 14:05:45 +0000",
            "to":[ "Recipient Name <recipient@example.com>" ],
            "messageId":"QA_JPkU2fkpIWdkxAOASH",
            "subject":"Message sent using Yandex Cloud Postbox"
        },
        "headers": [
            { "name": "From", "value": "User <user@example.com>" },
            { "name": "To", "value": "Recipient Name <recipient@example.com>" },
            { "name": "Subject", "value": "Message sent using Yandex Cloud Postbox" },
            { "name": "Date", "value": "Thu, 27 Jun 2024 14:05:45 +0000" },
            { "name": "Content-Type", "value": "text/plain; charset=UTF-8" },
            { "name": "X-Campaign-Id", "value": "summer-sale-2024" }
        ],
        "tags": {
            "ses:configuration-set": [
                "kXVCt2Vd4dvm3MDvpc5Ml"
            ],
            "ses:from-domain": [
                "example.com"
            ],
            "ses:source-ip": [
                "123.123.123.123"
            ],
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ]
        }
    },
    "bounce": {
        "bounceType": "Permanent",
        "bounceSubType": "Undetermined",
        "bouncedRecipients": [
            {
                "emailAddress": "abc@example.com",
                "action": "failed",
                "status": "5.7.1",
                "diagnosticCode": "Other"
            }
        ],
        "timestamp": "2024-04-25T18:08:04.973666+03:00",
        "dialAttempts": [
            {
                "mxHost": "mx.example.com.",
                "ip": "192.0.2.1",
                "reason": "Smtp",
                "error": "read response error: 554 5.7.1 Message rejected under suspicion of SPAM",
                "negotiatedTls": "TLSv1.3"
            }
        ]
    },
    "eventId": "jdMtnVniDeHqlQX8ygwEX:0"
}
```

### Уведомление о том, что письмо открыто {#open}

Приходит, когда получатель открыл письмо.

Пример уведомления:

```json
{
    "eventType": "Open",
    "mail": {
        "timestamp": "2024-04-25T18:08:04.933666+03:00",
        "messageId": "QA_JPkU2fkpIWdkxAOASH",
        "identityId": "ZtYk0rrjN87m-Ovxjte1G",
        "commonHeaders": {
            "from":[ "User <user@example.com>" ],
            "date":"Thu, 27 Jun 2024 14:05:45 +0000",
            "to":[ "Recipient Name <recipient@example.com>" ],
            "messageId":"QA_JPkU2fkpIWdkxAOASH",
            "subject":"Message sent using Yandex Cloud Postbox"
        },
        "headers": [
            { "name": "From", "value": "User <user@example.com>" },
            { "name": "To", "value": "Recipient Name <recipient@example.com>" },
            { "name": "Subject", "value": "Message sent using Yandex Cloud Postbox" },
            { "name": "Date", "value": "Thu, 27 Jun 2024 14:05:45 +0000" },
            { "name": "Content-Type", "value": "text/plain; charset=UTF-8" },
            { "name": "X-Campaign-Id", "value": "summer-sale-2024" }
        ],
        "tags": {
            "ses:configuration-set": [
                "kXVCt2Vd4dvm3MDvpc5Ml"
            ],
            "ses:from-domain": [
                "example.com"
            ],
            "ses:source-ip": [
                "123.123.123.123"
            ],
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ]
        }
    },
    "open": {
        "ipAddress": "192.0.2.1",
        "timestamp": "2024-04-25T18:08:04.933666+03:00",
        "userAgent": "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_3 like Mac OS X) AppleWebKit/603.3.8 (KHTML, like Gecko) Mobile/14G60"
    },
    "eventId": "jdMtnVniDeHqlQX8ygwEX:0"
}
```

### Уведомление о том, что получатель перешел по ссылке в письме {#click}

Приходит, когда получатель перешел по ссылке в письме.

Пример уведомления:

```json
{
    "eventType": "Click",
    "mail": {
        "timestamp": "2024-04-25T18:08:04.933666+03:00",
        "messageId": "QA_JPkU2fkpIWdkxAOASH",
        "identityId": "ZtYk0rrjN87m-Ovxjte1G",
        "commonHeaders": {
            "from":[ "User <user@example.com>" ],
            "date":"Thu, 27 Jun 2024 14:05:45 +0000",
            "to":[ "Recipient Name <recipient@example.com>" ],
            "messageId":"QA_JPkU2fkpIWdkxAOASH",
            "subject":"Message sent using {{ postbox-full-name }}"
        },
        "headers": [
            { "name": "From", "value": "User <user@example.com>" },
            { "name": "To", "value": "Recipient Name <recipient@example.com>" },
            { "name": "Subject", "value": "Message sent using Yandex Cloud Postbox" },
            { "name": "Date", "value": "Thu, 27 Jun 2024 14:05:45 +0000" },
            { "name": "Content-Type", "value": "text/plain; charset=UTF-8" },
            { "name": "X-Campaign-Id", "value": "summer-sale-2024" }
        ],
        "tags": {
            "ses:configuration-set": [
                "kXVCt2Vd4dvm3MDvpc5Ml"
            ],
            "ses:from-domain": [
                "example.com"
            ],
            "ses:source-ip": [
                "123.123.123.123"
            ],
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ]
        }
    },
    "click": {
        "ipAddress": "192.0.2.1",
        "timestamp": "2024-04-25T18:08:04.933666+03:00",
        "userAgent": "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_3 like Mac OS X) AppleWebKit/603.3.8 (KHTML, like Gecko) Mobile/14G60",
        "url": "https://example.com/some-link",
        "linkTags": {
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ]
        }
    },
    "eventId": "jdMtnVniDeHqlQX8ygwEX:0"
}
```

### Уведомление о том, что доставка письма задерживается {#delayed-delivery}

После того как {{ postbox-name }} успешно принял письмо, обычно оно отправляется немедленно. Однако иногда может возникнуть небольшая задержка доставки. В таком случае приходит данное уведомление.

Уведомление приходит только один раз — после первой неудачной попытки доставки. Если доставить письмо так и не удалось, придет [уведомление о том, что письмо не доставлено](#bounce).

Пример уведомления:

```json
{
    "eventType": "DeliveryDelay",
    "mail": {
        "timestamp": "2024-04-25T18:08:04.933666+03:00",
        "messageId": "QA_JPkU2fkpIWdkxAOASH",
        "identityId": "ZtYk0rrjN87m-Ovxjte1G",
        "commonHeaders": {
            "from":[ "User <user@example.com>" ],
            "date":"Thu, 27 Jun 2024 14:05:45 +0000",
            "to":[ "Recipient Name <recipient@example.com>" ],
            "messageId":"QA_JPkU2fkpIWdkxAOASH",
            "subject":"Message sent using Yandex Cloud Postbox"
        },
        "headers": [
            { "name": "From", "value": "User <user@example.com>" },
            { "name": "To", "value": "Recipient Name <recipient@example.com>" },
            { "name": "Subject", "value": "Message sent using Yandex Cloud Postbox" },
            { "name": "Date", "value": "Thu, 27 Jun 2024 14:05:45 +0000" },
            { "name": "Content-Type", "value": "text/plain; charset=UTF-8" },
            { "name": "X-Campaign-Id", "value": "summer-sale-2024" }
        ],
        "tags": {
            "ses:configuration-set": [
                "kXVCt2Vd4dvm3MDvpc5Ml"
            ],
            "ses:from-domain": [
                "example.com"
            ],
            "ses:source-ip": [
                "123.123.123.123"
            ],
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ]
        }
    },
    "deliveryDelay": {
        "delayType": "General",
        "delayedRecipients": [
            {
                "emailAddress": "recipient@example.com",
                "status": "4.4.1",
                "diagnosticCode": "421 4.4.1 Connection timed out"
            }
        ],
        "reportingMTA": "mx.example.com",
        "timestamp": "2024-04-25T18:10:04.973666+03:00"
    },
    "eventId": "jdMtnVniDeHqlQX8ygwEX:0"
}
```

### Уведомление о том, что получатель отписался от рассылки {#subscription}

Приходит, когда получатель отписался от рассылки через механизм «отказ от подписки в один клик» (`one-click unsubscribe`), добавленный {{ postbox-name }} в письмо.

Пример уведомления:

```json
{
    "eventType": "Subscription",
    "mail": {
        "timestamp": "2024-04-25T18:08:04.933666+03:00",
        "messageId": "QA_JPkU2fkpIWdkxAOASH",
        "identityId": "ZtYk0rrjN87m-Ovxjte1G",
        "commonHeaders": {
            "from":[ "User <user@example.com>" ],
            "date":"Thu, 27 Jun 2024 14:05:45 +0000",
            "to":[ "Recipient Name <recipient@example.com>" ],
            "messageId":"QA_JPkU2fkpIWdkxAOASH",
            "subject":"Message sent using Yandex Cloud Postbox"
        },
        "headers": [
            { "name": "From", "value": "User <user@example.com>" },
            { "name": "To", "value": "Recipient Name <recipient@example.com>" },
            { "name": "Subject", "value": "Message sent using Yandex Cloud Postbox" },
            { "name": "Date", "value": "Thu, 27 Jun 2024 14:05:45 +0000" },
            { "name": "Content-Type", "value": "text/plain; charset=UTF-8" },
            { "name": "X-Campaign-Id", "value": "summer-sale-2024" }
        ],
        "tags": {
            "ses:configuration-set": [
                "kXVCt2Vd4dvm3MDvpc5Ml"
            ],
            "ses:from-domain": [
                "example.com"
            ],
            "ses:source-ip": [
                "123.123.123.123"
            ],
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ]
        }
    },
    "subscription": {
        "contactList": "my-list",
        "timestamp": "2024-04-25T18:08:04.973666+03:00",
        "source": "UnsubscribeHeader"
    },
    "eventId": "jdMtnVniDeHqlQX8ygwEX:0"
}
```

### Уведомление о жалобе на письмо {#complaint}

Приходит, когда получатель пожаловался на полученное письмо, а интернет-провайдер (ISP) отправил эту жалобу в {{ postbox-name }}.

Пример уведомления:

```json
{
    "eventType": "Complaint",
    "mail": {
        "timestamp": "2024-04-25T18:08:04.933666+03:00",
        "messageId": "QA_JPkU2fkpIWdkxAOASH",
        "identityId": "ZtYk0rrjN87m-Ovxjte1G",
        "commonHeaders": {
            "from":[ "User <user@example.com>" ],
            "date":"Thu, 27 Jun 2024 14:05:45 +0000",
            "to":[ "Recipient Name <recipient@example.com>" ],
            "messageId":"QA_JPkU2fkpIWdkxAOASH",
            "subject":"Message sent using Yandex Cloud Postbox"
        },
        "headers": [
            { "name": "From", "value": "User <user@example.com>" },
            { "name": "To", "value": "Recipient Name <recipient@example.com>" },
            { "name": "Subject", "value": "Message sent using Yandex Cloud Postbox" },
            { "name": "Date", "value": "Thu, 27 Jun 2024 14:05:45 +0000" },
            { "name": "Content-Type", "value": "text/plain; charset=UTF-8" },
            { "name": "X-Campaign-Id", "value": "summer-sale-2024" }
        ],
        "tags": {
            "ses:configuration-set": [
                "kXVCt2Vd4dvm3MDvpc5Ml"
            ],
            "ses:from-domain": [
                "example.com"
            ],
            "ses:source-ip": [
                "123.123.123.123"
            ],
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ]
        }
    },
    "complaint": {
        "complainedRecipients": [
            {
                "emailAddress": "recipient@example.com"
            }
        ],
        "complaintFeedbackType": "abuse",
        "arrivalDate": "2024-04-25T18:05:04.84108+03:00",
        "timestamp": "2024-04-25T18:10:04.973666+03:00",
        "userAgent": "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_3 like Mac OS X) AppleWebKit/603.3.8 (KHTML, like Gecko) Mobile/14G60"
    },
    "eventId": "jdMtnVniDeHqlQX8ygwEX:0"
}
```

## Формат уведомлений {#format}

Уведомление записывается в [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-full-name }} в формате JSON. Последовательность и набор полей могут отличаться от описанных ниже.

### Основной объект {#main-object}

Название | Тип | Описание
--- | --- | ---
`eventType` | Строка | [Тип уведомления](#types). Возможные значения: `Bounce`, `Click`, `Complaint`, `Delivery`, `DeliveryDelay`, `Open`, `Rendering Failure`, `Send`, `Subscription`.
`mail` | Объект [Mail](#mail-object) | Объект, который содержит общую информацию об отправленном письме.
`send` | Объект [Send](#send-object) | Пустой объект. Обязателен, если `eventType` — `Send`, иначе отсутствует.
`bounce` | Объект [Bounce](#bounce-object) | Объект, который содержит информацию о том, что письмо не доставлено. Обязателен, если `eventType` — `Bounce`, иначе отсутствует.
`delivery` | Объект [Delivery](#delivery-object) | Объект, который содержит информацию о доставке письма отдельному получателю. Обязателен, если `eventType` — `Delivery`, иначе отсутствует.
`complaint` | Объект [Complaint](#complaint-object) | Объект, который содержит информацию о жалобе получателя на письмо. Обязателен, если `eventType` — `Complaint`, иначе отсутствует.
`subscription` | Объект [Subscription](#subscription-object) | Объект, который содержит информацию о том, что получатель отписался от рассылки. Обязателен, если `eventType` — `Subscription`, иначе отсутствует.
`deliveryDelay` | Объект [DeliveryDelay](#delivery-delay-object) | Объект, который содержит информацию о задержке доставки письма. Обязателен, если `eventType` — `DeliveryDelay`, иначе отсутствует.
`open` | Объект [Open](#open-object) | Объект, который содержит информацию о том, что письмо было открыто. Обязателен, если `eventType` — `Open`, иначе отсутствует.
`click` | Объект [Click](#click-object) | Объект, который содержит информацию о переходе по ссылке в письме. Обязателен, если `eventType` — `Click`, иначе отсутствует.
`failure` | Объект [Failure](#failure-object) | Объект, который содержит информацию об ошибке рендеринга письма. Обязателен, если `eventType` — `Rendering Failure`, иначе отсутствует.
`eventId` | Строка | Уникальный идентификатор события.

### Объект Mail {#mail-object}

Название | Тип | Описание
--- | --- | ---
`timestamp` | Строка | Дата в формате [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`). Время, когда письмо было принято {{ postbox-name }}.
`messageId` | Строка | Уникальный идентификатор письма. У одного письма может быть несколько получателей. Выдается {{ postbox-name }} при приеме письма в обработку.
`identityId` | Строка | Идентификатор адреса {{ postbox-name }}, который используется при отправке письма.
`commonHeaders` | Объект [CommonHeaders](#common-headers-object) | Объект, который содержит основные заголовки письма.
`headers` | Массив объектов [Header](#header-object) | Полный список заголовков письма в том виде, в котором они поступили в {{ postbox-name }} (до того как сервис добавил собственные служебные заголовки). Включает пользовательские заголовки, добавленные отправителем, например `X-Campaign-Id`. Поле отсутствует, если заголовки письма не сохранены.
`headersTruncated` | Логический | Поле присутствует, только если его значение — `true`. Если значение `true`, список `headers` неполный: его обрезали с конца, потому что суммарный размер заголовков превысил 10 КиБ.
`tags` | Объект | Объект, который содержит теги, добавленные к письму. Значение каждого тега — массив строк. Пользовательские теги всегда содержат только один элемент.

{% note info %}

В `headers` попадают заголовки письма в том виде, в котором их передал отправитель, включая пользовательские заголовки (например, `X-Campaign-Id`). Заголовки, которые {{ postbox-name }} добавляет или изменяет при обработке письма (например, `List-Unsubscribe`, `List-Unsubscribe-Post`, `DKIM-Signature`), в `headers` не попадают. Порядок заголовков сохраняется.

{% endnote %}

{% note info %}

`headers` содержит исходные заголовки письма, а `commonHeaders` — итоговые, полученные после обработки письма сервисом. Поэтому `commonHeaders.messageId` — это идентификатор, выданный {{ postbox-name }}, а в `headers` может находиться собственный заголовок `Message-Id` отправителя.

Значения заголовков передаются в уведомлении без изменений — в том виде, в каком они содержались в письме. Если заголовок закодирован в соответствии с [RFC 2047](https://www.ietf.org/rfc/rfc2047.txt) (например, тема письма или отображаемое имя отправителя на кириллице), в уведомление попадет закодированное значение. Раскодировать его нужно на стороне получателя уведомления. Это касается всех элементов `headers`, а также полей `commonHeaders.from`, `commonHeaders.to` и `commonHeaders.subject`.

{% endnote %}

### Объект CommonHeaders {#common-headers-object}

Название | Тип | Описание
--- | --- | ---
`from` | Массив строк | Содержимое заголовка `From`, разбитое по адресам. Пустое значение, если заголовка в письме не было. Если разобрать значение по адресам не удалось, массив содержит один элемент — исходную строку заголовка целиком.
`to` | Массив строк | Содержимое заголовка `To`, разбитое по адресам. Пустое значение, если заголовка в письме не было. Если разобрать значение по адресам не удалось, массив содержит один элемент — исходную строку заголовка целиком.
`subject` | Строка | Содержимое заголовка `Subject`. Пустая строка, если заголовка в письме не было.
`date` | Строка | Содержимое заголовка `Date`. Пустая строка, если заголовка в письме не было.
`messageId` | Строка | Уникальный идентификатор письма. Выдается {{ postbox-name }} при приеме письма.
`originalMessageId` | Строка | Значение заголовка `Original-Message-ID`, если отправитель передал его в письме. Иначе — пустая строка.

### Объект Header {#header-object}

Название | Тип | Описание
--- | --- | ---
`name` | Строка | Имя заголовка письма.
`value` | Строка | Значение заголовка письма.

### Объект Send {#send-object}

Пустой объект.

### Объект Bounce {#bounce-object}

Название | Тип | Описание
--- | --- | ---
`bounceType` | Строка | Тип ошибки. Возможные значения:<ul><li>`Permanent` — письмо не доставлено.</li></ul>
`bounceSubType` | Строка | Подтип ошибки. Возможные значения:<ul><li>`Undetermined` — неизвестная ошибка;</li><li>`OnAccountSuppressionList` — письмо не отправлено, потому что получатель находится в [пользовательском стоп-листе](suppression-list.md#user);</li><li>`Suppressed` — письмо не отправлено, потому что получатель находится в [глобальном стоп-листе](suppression-list.md#global);</li><li>`InsufficientTLS` — не удалось установить TLS-соединение нужного уровня с сервером получателя;</li><li>`StartTlsNotOffered` — сервер получателя не поддерживает команду `STARTTLS`;</li><li>`TlsCertificateUntrusted` — сертификат сервера получателя не является доверенным;</li><li>`TlsVersionTooLow` — версия TLS, которую поддерживает сервер получателя, ниже допустимой.</li></ul>
`bouncedRecipients` | Массив объектов [BounceRecipient](#bounce-recipent-object) | Массив, который содержит информацию о получателе письма и связанной с ним ошибке доставки, если она была.
`dialAttempts` | Массив объектов [DialAttempt](#dial-attempt-object) | Необязательное поле. Список попыток подключения к почтовым серверам получателя с описанием ошибки по каждой попытке. Отсутствует, если подключение не выполнялось, — например, когда адрес получателя находится в стоп-листе.
`timestamp` | Строка | Дата в формате [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`). Время, когда получена ошибка от почтового клиента получателя.

### Объект BounceRecipent {#bounce-recipent-object}

Название | Тип | Описание
--- | --- | ---
`emailAddress` | Строка | Электронный адрес получателя.
`action` | Строка | Необязательное поле. Результат отправки. Возможные значения: `failed`.
`status` | Строка | Необязательное поле. SMTP-код ответа.
`diagnosticCode` | Строка | Необязательное поле. Расширенный текст ошибки. Для ошибки, полученной от сервера получателя, содержит текст ответа этого сервера. В остальных случаях принимает одно из фиксированных значений: `Host or MX not found`, `Too many attempts`, `Spam detected`, `Insufficient TLS`, `STARTTLS not offered by recipient MX`, `TLS certificate not trusted`, `TLS version too low`, `Blocked by Global Suppression List`, `Blocked by Account Suppression List`, `Other`, `Unknown`.

### Объект DialAttempt {#dial-attempt-object}

Название | Тип | Описание
--- | --- | ---
`mxHost` | Строка | Имя почтового сервера получателя (MX-хоста), к которому выполнялось подключение. Передается в виде полного доменного имени (FQDN) и может содержать точку в конце.
`ip` | Строка | IP-адрес, к которому выполнялось подключение.
`reason` | Строка | Код причины ошибки. Возможные значения: `Smtp`, `HostOrMXNotFound`, `Spam`, `TooManyAttempts`, `InsufficientTLS`, `StartTlsNotOffered`, `TlsCertUntrusted`, `TlsVersionTooLow`, `Other`.
`error` | Строка | Текст ошибки для этой попытки подключения. Содержимое поля не имеет фиксированного формата и может меняться, поэтому опираться на него при программной обработке не следует — для этого предназначено поле `reason`.
`negotiatedTls` | Строка | Необязательное поле. Версия TLS, согласованная с сервером получателя, например `TLSv1.2`. Отсутствует, если TLS-соединение не было установлено.

### Объект Click {#click-object}

Название | Тип | Описание
--- | --- | ---
`ipAddress` | Строка | IP-адрес устройства получателя, с которого перешли по ссылке.
`timestamp` | Строка | Дата в формате [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`). Время, когда получатель перешел по ссылке.
`userAgent` | Строка | Идентификационная строка (`User-Agent`) устройства или почтового клиента, с которого перешли по ссылке.
`url` | Строка | Оригинальный URL, по которому перешел получатель.
`linkTags` | Объект | Объект, который содержит теги, добавленные к ссылке.

### Объект Complaint {#complaint-object}

Название | Тип | Описание
--- | --- | ---
`complainedRecipients` | Массив объектов [ComplainedRecipient](#complained-recipient-object) | Массив, который содержит информацию о получателях, которые могли подать жалобу.
`timestamp` | Строка | Дата в формате [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`). Время, когда интернет-провайдер отправил жалобу в {{ postbox-name }}.
`complaintFeedbackType` | Строка | Необязательное поле. Тип жалобы из отчета интернет-провайдера. Возможные значения:<ul><li>`abuse` — нежелательная почта или иное злоупотребление;</li><li>`auth-failure` — ошибка аутентификации письма;</li><li>`fraud` — фишинг или мошенничество;</li><li>`not-spam` — получатель не считает письмо спамом (используется для исправления ложного срабатывания);</li><li>`other` — жалоба, не соответствующая остальным типам;</li><li>`virus` — в письме обнаружен вирус.</li></ul>
`arrivalDate` | Строка | Необязательное поле. Дата в формате [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`). Время, когда оригинальное письмо поступило на сервер получателя.
`userAgent` | Строка | Необязательное поле. Значение поля `User-Agent` из отчета о жалобе — имя и версия системы, которая сгенерировала отчет.

### Объект ComplainedRecipient {#complained-recipient-object}

Название | Тип | Описание
--- | --- | ---
`emailAddress` | Строка | Электронный адрес получателя, который мог подать жалобу.

### Объект Delivery {#delivery-object}

Название | Тип | Описание
--- | --- | ---
`timestamp` | Строка | Дата в формате [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`). Время, когда {{ postbox-name }} отправил письмо и получил успешный ответ от почтового клиента получателя.
`processingTimeMillis` | Целое число | Время, которое потребовалось на обработку письма в миллисекундах.
`recipients` | Массив строк | Адреса получателей.

### Объект DeliveryDelay {#delivery-delay-object}

Название | Тип | Описание
--- | --- | ---
`delayType` | Строка | Тип задержки. Возможные значения: `General`.
`delayedRecipients` | Массив объектов [DelayedRecipient](#delayed-recipient-object) | Массив, который содержит информацию о получателе письма и связанной с ним задержке доставки.
`reportingMTA` | Строка | Имя почтового сервера получателя, который сообщил о задержке доставки. Может быть пустой строкой, если сервер определить не удалось.
`timestamp` | Строка | Дата в формате [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`). Время, когда случилась задержка доставки.

### Объект DelayedRecipient {#delayed-recipient-object}

Название | Тип | Описание
--- | --- | ---
`emailAddress` | Строка | Электронный адрес получателя.
`status` | Строка | SMTP-код ответа сервера получателя. Может быть пустой строкой.
`diagnosticCode` | Строка | Необязательное поле. Расширенный текст ошибки. Может содержать текст ответа сервера получателя.

### Объект Failure {#failure-object}

Название | Тип | Описание
--- | --- | ---
`errorMessage` | Строка | Описание ошибки рендеринга.
`templateName` | Строка | Необязательное поле. Имя шаблона, при рендеринге которого возникла ошибка, если оно передается в уведомлении.

### Объект Subscription {#subscription-object}

Название | Тип | Описание
--- | --- | ---
`contactList` | Строка | Имя списка контактов, с которым связано письмо.
`timestamp` | Строка | Дата в формате [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`). Время, когда получатель отписался от рассылки.
`source` | Строка | Источник отписки. Возможные значения: `UnsubscribeHeader`.

### Объект Open {#open-object}

Название | Тип | Описание
--- | --- | ---
`ipAddress` | Строка | IP-адрес устройства получателя, с которого было открыто письмо.
`timestamp` | Строка | Дата в формате [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`). Время, когда письмо было открыто.
`userAgent` | Строка | Идентификационная строка (`User-Agent`) устройства или почтового клиента, с которого было открыто письмо.

## Системные теги {#system-tags}

При отправке письма {{ postbox-name }} добавляет к письму следующие системные теги, которые затем включаются в уведомления.

Общие теги:

Название | Описание
--- | ---
`ses:configuration-set` | Идентификатор [конфигурации](glossary.md#configuration), использованной при отправке письма.
`ses:from-domain` | Домен, с которого отправлено письмо.
`ses:source-ip` | IP-адрес сервера, с которого пользователь отправил письмо в {{ postbox-name }}.

Дополнительные теги, которые включаются только в [уведомления о доставке](#delivery):

Название | Описание
--- | ---
`ses:outgoing-tls-version` | Версия TLS, использованная при отправке письма на сервер получателя.
`ses:outgoing-tls-cipher` | Шифр TLS, использованный при отправке письма на сервер получателя.
`ses:outgoing-ip` | IP-адрес сервера, с которого {{ postbox-name }} отправил письмо на сервер получателя.

## Уровень качества обслуживания (QoS) {#qos}

При доставке уведомлений сервис поддерживает [уровень качества обслуживания](../../glossary/qos.md) `QoS 1: At least once`, поэтому возможна повторная отправка уведомлений. У одинаковых уведомлений совпадает `eventId`.

Если к адресу привязана [конфигурация](glossary.md#configuration), в которую добавлены несколько [подписок](glossary.md#subscription), по каждому назначению будет приходить отдельное уведомление.

## Пример работы {#example}

Вы отправили письмо двум получателям — `user1@example.com` и `user2@other.example.com`. {{ postbox-name }} отправил письмо обоим получателям отдельно.

Почтовый клиент получателя `user1@example.com` принял письмо. Почтовый клиент получателя `user2@other.example.com` после первой попытки отправить письмо вернул ошибку, а после второй — не принял письмо и ответил, что данный пользователь не найден.

В таком случае вы получите три уведомления:

* уведомление о том, что {{ postbox-name }} принял письмо в обработку;
* уведомление о доставке письма получателю `user1@example.com`;
* уведомление о том, что письмо не доставлено получателю `user2@other.example.com`, с информацией об ошибке. Уведомление придет после второй попытки отправить письмо.

Так как почтовый клиент ответил, что получатель `user2@other.example.com` не найден, его адрес временно попадет в [глобальный стоп-лист](suppression-list.md#global). Прежде чем пытаться отправлять письмо на такой адрес повторно, необходимо подождать некоторое время, иначе придет уведомление о том, что письмо не доставлено, потому что получатель находится в глобальном стоп-листе.
