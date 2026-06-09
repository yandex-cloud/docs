# Действие SetSMSChannelAttributes

Задать параметры [канала SMS-уведомлений](../concepts/sms.md).

## HTTP-запрос {#request}

```http
POST https://{{ cns-host }}/
```

### Query-параметры {#parameters}

Параметр | Описание
--- | ---
`Action` | **string**<br/>Обязательное поле.<br/>Параметр для обозначения типа операции.<br/>Значение: `SetSMSChannelAttributes`.
`SMSChannelArn` | **string**<br/>Обязательное поле.<br/>Идентификатор канала SMS-уведомлений.<br/>Пример: `arn:aws:sns::b1gvlrnlei4l******:sms/channelname`.
`Attributes.entry.N.key` | **string**<br/>Обязательное поле.<br/>Ключ [атрибута](#attributes). `N` — числовое значение.<br/>Пример: `Attributes.entry.1.key=Description`.
`Attributes.entry.N.value` | **string**<br/>Обязательное поле.<br/>Значение атрибута. `N` — числовое значение.<br/>Пример: `Attributes.entry.1.value=Test-sms-channel`.
`ResponseFormat` | **string**<br/>Формат ответа.<br/>Возможные значения:<ul><li>`XML` (по умолчанию).</li><li>`JSON`.</li></ul>

### Атрибуты {#attributes}

Атрибут | Описание
--- | ---
`IsDefault` | Указывает, является ли данный канал каналом по умолчанию при отправке SMS в этом облаке. Установить `IsDefault` можно только для канала в состоянии `Sandbox` или `Active`. Из-за особенностей {{ cns-name }} этот атрибут нельзя передавать вместе с другими атрибутами.
`ChannelState` | Целевое состояние канала. Возможные состояния:<ul><li>`Active` — активен.</li><li>`Disabled` — отключен.</li></ul>
`Description` | Описание канала SMS-уведомлений.<br/>Пример: `Test-sms-channel`.

## Ответ {#response}

### Успешный ответ {#response-200}

При отсутствии ошибок {{ cns-name }} отвечает HTTP-кодом `200`.

Успешный ответ содержит дополнительные данные в формате XML или JSON в зависимости от указанного параметра `ResponseFormat`.

Схема данных:

{% list tabs %}

- XML

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <SetSMSChannelAttributesResponse>
	  <ResponseMetadata>
		  <RequestId>string</RequestId>
	  </ResponseMetadata>
  </SetSMSChannelAttributesResponse>
  ```

- JSON

  ```json
  {
    "ResponseMetadata": {
      "RequestId": "string"
    }
  }
  ```

{% endlist %}

Где `RequestId` — идентификатор запроса.

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

Ошибки, специфичные для действия `SetSMSChannelAttributes`:

HTTP | Код ошибки | Дополнительный код | Описание
--- | --- | --- | ---
400 | UserError | InvalidSMSChannelStateTransition | Невозможно перейти в указанное состояние канала.
400 | UserError | InvalidSMSChannelStateToSetDefault | Невозможно установить канал в текущем состоянии в качестве канала по умолчанию.
400 | UserError | InvalidSMSChannelAttributeCombination | Атрибут `IsDefault` нельзя передавать вместе с другими атрибутами.

## См. также {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)