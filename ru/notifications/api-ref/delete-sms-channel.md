# Действие DeleteSMSChannel

Удаляет [канал SMS-уведомлений](../concepts/sms.md).

## HTTP-запрос {#request}

```http
POST https://{{ cns-host }}/
```

### Query-параметры {#parameters}

Параметр | Описание
--- | ---
`Action` | **string**<br/>Обязательное поле.<br/>Параметр для обозначения типа операции.<br/>Значение: `DeleteSMSChannel`.
`SMSChannelArn` | **string**<br/>Обязательное поле.<br/>Идентификатор канала SMS-уведомлений.<br/>Пример: `arn:aws:sns::b1gvlrnlei4l******:sms/channelname`.
`ResponseFormat` | **string**<br/>Формат ответа.<br/>Возможные значения:<ul><li>`XML` (по умолчанию).</li><li>`JSON`.</li></ul>

## Ответ {#response}

### Успешный ответ {#response-200}

При отсутствии ошибок {{ cns-name }} отвечает HTTP-кодом `200`.

Успешный ответ содержит дополнительные данные в формате XML или JSON в зависимости от указанного параметра `ResponseFormat`.

Схема данных:

{% list tabs %}

- XML

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <DeleteSMSChannelResponse>
	  <ResponseMetadata>
		  <RequestId>string</RequestId>
	  </ResponseMetadata>
  </DeleteSMSChannelResponse>
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

Ошибки, специфичные для действия `DeleteSMSChannel`:

HTTP | Код ошибки | Дополнительный код | Описание
--- | --- | --- | ---
400 | UserError | SMSChannelIsNotDeregistered | канала SMS-уведомлений не находится в состоянии `Deregistered`.
400 | UserError | DefaultSMSChannelDeletionForbidden | Нельзя удалить канала SMS-уведомлений, установленный по умолчанию.

## См. также {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)