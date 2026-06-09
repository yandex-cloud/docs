# Действие CreateSMSChannel

Создает [канал SMS-уведомлений](../concepts/sms.md).

## HTTP-запрос {#request}

```http
POST https://{{ cns-host }}/
```

### Query-параметры {#parameters}

Параметр | Описание
--- | ---
`Action` | **string**<br/>Обязательное поле.<br/>Параметр для обозначения типа операции.<br/>Значение: `CreateSMSChannel`.
`SenderID` | **string**<br/>Текстовое имя отправителя. Если имя не задано, создается канал SMS-уведомлений с [общим отправителем](../concepts/sms.md#common-sender) в [песочнице](../concepts/sms.md#sandbox). В облаке может быть только один канал с общим отправителем.
`FolderId` | **string**<br/>Обязательное поле при аутентификации через IAM-токен.<br/>[Идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором создается канал SMS-уведомлений. При аутентификации через статический ключ сервисного аккаунта, если FolderId не указан, канал создается в одном каталоге с сервисным аккаунтом.<br/>Пример: `b1gsm0k26v1l********`.
`Attributes.entry.N.key` | **string**<br/>Обязательное поле.<br/>Ключ [атрибута](#attributes). `N` — числовое значение.<br/>Пример: `Attributes.entry.1.key=Description`.
`Attributes.entry.N.value` | **string**<br/>Обязательное поле.<br/>Значение атрибута. `N` — числовое значение.<br/>Пример: `Attributes.entry.1.value=Test-sms-channel`.
`ResponseFormat` | **string**<br/>Формат ответа.<br/>Возможные значения:<ul><li>`XML` (по умолчанию).</li><li>`JSON`.</li></ul>

### Атрибуты {#attributes}

Атрибут | Описание
--- | ---
`Description` | **string**<br/>Описание канала SMS-уведомлений.<br/>Пример: `Test-sms-channel`.

## Ответ {#response}

### Успешный ответ {#response-200}

При отсутствии ошибок {{ cns-name }} отвечает HTTP-кодом `200`.

Успешный ответ содержит дополнительные данные в формате XML или JSON в зависимости от указанного параметра `ResponseFormat`.

Схема данных:

{% list tabs %}

- XML

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <CreateSMSChannelResponse>
	  <ResponseMetadata>
		  <RequestId>string</RequestId>
	  </ResponseMetadata>
	  <CreateSMSChannelResult>
		  <SMSChannelArn>string</SMSChannelArn>
	  </CreateSMSChannelResult>
  </CreateSMSChannelResponse>
  ```

- JSON

  ```json
  {
    "ResponseMetadata": {
      "RequestId": "string"
    },
    "CreateSMSChannelResult": {
      "SMSChannelArn": "string"
    }
  }
  ```

{% endlist %}

Где:
* `RequestId` — идентификатор запроса.
* `SMSChannelArn` — идентификатор (ARN) канала SMS-уведомлений.

### Ответ с ошибкой {#response-4xx}

При возникновении ошибки {{ cns-name }} отвечает сообщением с соответствующим HTTP-кодом и дополнительным описанием в формате XML или JSON в зависимости от указанного параметра `ResponseFormat`.

Схема данных:

{% list tabs %}

- XML

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <ErrorResponseXML>
	  <RequestId>string</RequestId>
	  <Error>
		  <Code>string</Code>
		  <Message>string</Message>
	  </Error>
  </ErrorResponseXML>
  ```

- JSON

  ```json
  {
    "ErrorResponse": {
      "RequestId": "string",
      "Error": {
        "Code": "string",
        "SubCode": "string",
        "Message": "string"
      }
    }
  }
  ```

{% endlist %}

Где:
* `RequestId` — идентификатор запроса.
* `Code` — код ошибки.
* `Message` — описание ошибки.

Перечень общих кодов ошибок для всех действий см. в разделе [{#T}](common-errors.md).

Ошибки, специфичные для действия `CreateSMSChannel`:

HTTP | Код ошибки | Дополнительный код | Описание
--- | --- | --- | ---
400 | UserError | SMSChannelLimitExceeded | Превышен лимит на число каналов SMS-уведомлений в облаке.
400 | UserError | ChannelAlreadyExists | В облаке есть канал SMS-уведомлений с таким же текстовым именем отправителя.

## См. также {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)