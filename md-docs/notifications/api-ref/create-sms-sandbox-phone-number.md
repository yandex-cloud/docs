# Действие CreateSMSSandboxPhoneNumber

Добавляет тестовый телефонный номер для канала SMS-уведомлений в [песочнице](../concepts/sms.md#sandbox) и отправляет на него код подтверждения.

Если телефонный номер уже есть в списке в ожидании подтверждения, повторно отправляет на него новый код подтверждения.

## HTTP-запрос {#request}

```http
POST https://{{ cns-host }}/
```

### Query-параметры {#parameters}

Параметр | Описание
--- | ---
`Action` | **string**<br/>Обязательное поле.<br/>Параметр для обозначения типа операции.<br/>Значение: `CreateSMSSandboxPhoneNumber`.
`PhoneNumber` | **string**<br/>Обязательное поле.<br/>Номер телефона в формате [E.164](https://ru.wikipedia.org/wiki/E.164).
`SMSChannelArn` | **string**<br/>Обязательное поле.<br/>Идентификатор канала SMS-уведомлений.<br/>Пример: `arn:aws:sns::b1gvlrnlei4l******:sms/channelname`.
`LanguageCode` | **string**<br/>Код языка, используемый для отправки кода подтверждения.<br/>Возможные значения:<ul><li>`en-US` (по умолчанию).</li><li>`ru-RU`.</li></ul>
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
  <CreateSMSSandboxPhoneNumberResponse>
	  <ResponseMetadata>
		  <RequestId>string</RequestId>
	  </ResponseMetadata>
  </CreateSMSSandboxPhoneNumberResponse>
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

Ошибки, специфичные для действия `CreateSMSSandboxPhoneNumber`:

HTTP | Код ошибки | Дополнительный код | Описание
--- | --- | --- | ---
400 | UserError | SMSSandboxPhoneNumberLimitExceeded | Исчерпан [лимит](../concepts/limits.md) на количество подтвержденных номеров на облако или канал SMS-уведомлений.
400 | UserError | WrongSMSChannelState | Канал SMS-уведомлений не находится в статусе `Sandbox`.
400 | UserError | SMSSandboxPhoneNumberAlreadyVerified | Указанный номер уже подтвержден в данном канале SMS-уведомлений.
400 | UserError | InvalidPhoneNumberRegion | Нельзя использовать телефонные номера не из России.
400 | ThrottlingException | OTPRateLimitExceeded | Превышена допустимая частота отправки кодов подтверждения.

## См. также {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)
* [CreateSMSSandboxPhoneNumber](https://docs.aws.amazon.com/sns/latest/api/API_CreateSMSSandboxPhoneNumber.html) в документации AWS.