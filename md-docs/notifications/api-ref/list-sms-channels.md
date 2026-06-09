# Действие ListSMSChannels

Получает список [каналов SMS-уведомлений](../concepts/sms.md) в каталоге.

## HTTP-запрос {#request}

```http
POST https://{{ cns-host }}/
```

### Query-параметры {#parameters}

Параметр | Описание
--- | ---
`Action` | **string**<br/>Обязательное поле.<br/>Параметр для обозначения типа операции.<br/>Значение: `ListSMSChannels`.
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
  <ListSMSChannelsResponseXML>
	  <ResponseMetadata>
	  	<RequestId>string</RequestId>
	  </ResponseMetadata>
	  <ListSMSChannelsResult>
	  	<SMSChannels>
			  <member>
			  	<SMSChannelArn>string</SMSChannelArn>
			  	<Attributes>
				  	<entry>
					  	<key>string</key>
					  	<value>string</value>
					  </entry>
				  </Attributes>
			  </member>
		  </SMSChannels>
	  </ListSMSChannelsResult>
  </ListSMSChannelsResponseXML>
  ```

- JSON

  ```json
  {
    "ResponseMetadata": {
      "RequestId": "string"
    },
    "ListSMSChannelsResult": {
      "SMSChannels": [
        {
          "SMSChannelArn": "string",
          "Attributes": {
            "Attribute": "string"
          }
        }
      ]
    }
  }
  ```

{% endlist %}

Где:
* `RequestId` — идентификатор запроса.
* `SMSChannelArn` — идентификатор (ARN) канала SMS-уведомлений.
* `Attributes` — атрибуты канала SMS-уведомлений:
  * `SenderID`:
    * для каналов с индивидуальным отправителем — содержит текстовое имя отправителя, переданное при создании канала. 
    * для канала с общим отправителем — содержит значение `cns.shared`.
  * `IsDefault` — указывает, является ли данный канал каналом по умолчанию при отправке SMS в этом облаке.
  * `IsBanned` — указывает, заблокирован ли канал сервисом.
  * `ChannelState` — состояние канала. Возможные состояния: 
    * `Registering` — регистрируется.
    * `Sandbox` — в [песочнице](../concepts/sms.md#sandbox).
    * `Active` — активен.
    * `Disabled` — отключен.
    * `Deregistering` — снимается с регистрации.
    * `Deregistered` — снят с регистрации.
  * `Description` — описание SMS-уведомлений.

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