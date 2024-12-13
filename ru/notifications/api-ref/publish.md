# Действие Publish

Отправляет Push-уведомление в [эндпоинт](../concepts/index.md#mobile-endpoints).

## HTTP-запрос {#request}

```http
POST https://{{ cns-host }}/
```

### Query-параметры {#parameters}

Параметр | Описание
--- | ---
`Action` | **string**<br/>Обязательное поле.<br/>Параметр для обозначения типа операции.<br/>Значение: `Publish`.
`Message` | **string**<br/>Обязательное поле.<br/>Сообщение, которое вы хотите отправить в эндпоинт.<br/> Возможные форматы:<ul><li>Простой текст.</li><li>JSON.</li></ul><br/>В формате JSON вы можете опционально передать текст для конкретной мобильной платформы, например:<br/>`{ "default": "This is the default message which must be present when publishing a message to a topic. The default message will only be used if a message is not present for one of the notification platforms.", "APNS": "{"aps":{"alert": "Check out these awesome deals!","url":"yandex.cloud"} }", "GCM": "{"data":{"message":"Check out these awesome deals!","url":"yandex.cloud"},"notification":{"title":"GCM notification title"}}" "HMS": "{"data":{"message":"Check out these awesome deals!","url":"yandex.cloud"},"notification":{"title":"HMS notification title"}}" }`<br/>В сообщениях для платформ FCM и HMS обязательно должно присутствовать хотя бы одно из полей `data` или `notification`.
`MessageStructure` | **string**<br/> Если в поле `Message` вы передаете сообщение в формате JSON, задайте в поле `MessageStructure` значение `json`.
`MessageAttributes.entry.N.Name` | **string**<br/>Обязательное поле.<br/>Имя [атрибута](#attributes). `N` — числовое значение.<br/>Пример: `MessageAttributes.entry.1.Name=FirstName&MessageAttributes.entry.2.Name=SecondName`.
`MessageAttributes.entry.N.Value.DataType` | **string**<br/>Обязательное поле.<br/>Тип данных атрибута. `N` — числовое значение.<br/>Пример: `MessageAttributes.entry.1.Value.DataType=String&MessageAttributes.entry.2.Value.DataType=Number`.
`MessageAttributes.entry.N.Value.StringValue` | **string**<br/>Обязательное поле.<br/>Значение атрибута. `N` — числовое значение.<br/>Пример: `MessageAttributes.entry.1.Value.StringValue=background&MessageAttributes.entry.2.Value.StringValue=5`.
`TargetArn` | **string**<br/>Обязательное поле.<br/>Идентификатор (ARN) мобильного эндпоинта.<br/>Пример: `arn:aws:sns::aoegtvhtp8ob********:endpoint/GCM/test-cns-9990/4cbe148515360244248c993abe0a12884d162bb15e87d6c16bd0c810********`.
`ResponseFormat` | **string**<br/>Формат ответа.<br/>Возможные значения:<ul><li>`XML` (по умолчанию).</li><li>`JSON`.</li></ul>

### Атрибуты {#attributes}

С помощью атрибутов вы можете передать специфичные для мобильной платформы параметры. В значениях `MessageAttributes` нельзя передать бинарные данные.

#### Атрибуты APNS и APNS_SANDBOX {#attributes-apns}

Атрибут | Описание
--- | ---
AWS.SNS.MOBILE.APNS.TTL | Время жизни уведомления в секундах.
AWS.SNS.MOBILE.APNS_SANDBOX.TTL | Время жизни уведомления в секундах. Для тестируемых приложений.
AWS.SNS.MOBILE.APNS_VOIP.TTL | Время жизни уведомления о входящем VoIP-вызове в секундах.
AWS.SNS.MOBILE.APNS_VOIP_SANDBOX.TTL | Время жизни уведомления о входящем VoIP-вызове в секундах. Для тестируемых приложений.
AWS.SNS.MOBILE.APNS.COLLAPSE_ID | Идентификатор для нескольких уведомлений, которые сворачиваются в одно.
AWS.SNS.MOBILE.APNS.PRIORITY | Приоритет вывода уведомления. Значение от `1` до `10`.
AWS.SNS.MOBILE.APNS.PUSH_TYPE | Тип уведомления. Подробнее см. в [документации Apple](https://developer.apple.com/documentation/usernotifications/sending-notification-requests-to-apns#Know-when-to-use-push-types).
AWS.SNS.MOBILE.APNS.TOPIC | Тема уведомления. Подробнее см. в [документации Apple](https://developer.apple.com/documentation/usernotifications/sending-notification-requests-to-apns#Send-a-POST-request-to-APNs).

#### Атрибуты FCM {#attributes-fcm}

Атрибут | Описание
--- | ---
AWS.SNS.MOBILE.FCM.TTL | Время жизни сообщения в секундах.

## Ответ {#response}

### Успешный ответ {#response-200}

При отсутствии ошибок {{ cns-name }} отвечает HTTP-кодом `200`.

### Ответ с ошибкой {#response-4xx}

При возникновении ошибки {{ cns-name }} отвечает сообщением с соответствующим HTTP-кодом.

Перечень общих кодов ошибок для всех действий см. в разделе [{#T}](common-errors.md).

## См. также {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)
* [API action Publish](https://docs.aws.amazon.com/sns/latest/api/API_Publish.html) в документации AWS.
