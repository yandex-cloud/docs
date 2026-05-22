# Действие ListSMSSandboxPhoneNumbers

Получает список тестовый телефонных номеров для канала SMS-уведомлений в [песочнице](../concepts/sms.md#sandbox).

## HTTP-запрос {#request}

```http
POST https://{{ cns-host }}/
```

### Query-параметры {#parameters}

Параметр | Описание
--- | ---
`Action` | **string**<br/>Обязательное поле.<br/>Параметр для обозначения типа операции.<br/>Значение: `ListSMSSandboxPhoneNumbers`.
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
  <ListSMSSandboxPhoneNumbersResponseXML>
	  <ResponseMetadata>
	  	<RequestId>string</RequestId>
  	</ResponseMetadata>
  	<ListSMSSandboxPhoneNumbersResult>
	  	<PhoneNumbers>
	  		<member>
		  		<PhoneNumber>string</PhoneNumber>
		  		<Status>Pending</Status>
		  	</member>
	  	</PhoneNumbers>
	  </ListSMSSandboxPhoneNumbersResult>
  </ListSMSSandboxPhoneNumbersResponseXML>
  ```

- JSON

  ```json
  {
    "ResponseMetadata": {
      "RequestId": "string"
    },
    "ListSMSSandboxPhoneNumbersResult": {
      "PhoneNumbers": [
        {
          "PhoneNumber": "string",
          "Status": "Pending",
          "IsDeletable": true
        }
      ]
    }
  }
  ```

{% endlist %}

Где:
* `RequestId` — идентификатор запроса.
* `PhoneNumber` — номер телефона.
* `Status` — статус номера:
  * `Pending` — ожидается подтверждение.
  * `Verified` — подтвержден.
* `IsDeletable` — возможность удалить номер телефона. Тестовый номер можно удалить только спустя 24 часа после его добавления.

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

## См. также {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)
* [ListSMSSandboxPhoneNumbers](https://docs.aws.amazon.com/sns/latest/api/API_ListSMSSandboxPhoneNumbers.html) в документации AWS.