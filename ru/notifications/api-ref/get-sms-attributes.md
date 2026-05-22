# Действие GetSMSAttributes

Получает параметры для отправки SMS в [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud).

## HTTP-запрос {#request}

```http
POST https://{{ cns-host }}/
```

### Query-параметры {#parameters}

Параметр | Описание
--- | ---
`Action` | **string**<br/>Обязательное поле.<br/>Параметр для обозначения типа операции.<br/>Значение: `GetSMSAttributes`.
`Attributes.member.N` | **string**<br/>Имя атрибута, значение которого нужно получить.<br/>Возможные значения:<ul><li>`MonthlySMSCountQuota` — [лимит](../concepts/limits.md) в облаке на количество отправленных SMS в месяц.</li><li>`DefaultSenderID` — Идентификатор отправителя, используемый по умолчанию.</li><li>`DefaultSMSType` — Тип SMS (`Promotional`, `Transactional`), используемый по умолчанию.</li></ul><br/>Если ни один из атрибутов не передан, в ответе будут возвращены все поддерживаемые атрибуты.<br/>Пример: `Attributes.member.1=MonthlySMSCountQuota`.
`Account` | **string**<br/>Идентификатор облака. Используется только для отправки SMS. Обязателен, если авторизация происходит по [IAM-токену](../../iam/concepts/authorization/iam-token.md).
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
  <GetSMSAttributesResponseXML>
  	<ResponseMetadata>
  		<RequestId>string</RequestId>
  	</ResponseMetadata>
  	<GetSMSChannelAttributesResult>
	  	<Attributes>
		  	<entry>
			  	<key>string</key>
		  		<value>string</value>
	  		</entry>
  		</Attributes>
  	</GetSMSChannelAttributesResult>
  </GetSMSAttributesResponseXML>
  ```

- JSON

  ```json
  {
    "ResponseMetadata": {
      "RequestId": "string"
    },
    "GetSMSAttributesResult": {
      "Attributes": {
        "Attribute": "string"
      }
    }
  }
  ```

{% endlist %}

Где:
* `RequestId` — идентификатор запроса.
* `Attributes` — параметры для отправки SMS в облаке.

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
* [API action GetSMSAttributes](https://docs.aws.amazon.com/sns/latest/api/API_GetSMSAttributes.html) в документации AWS.