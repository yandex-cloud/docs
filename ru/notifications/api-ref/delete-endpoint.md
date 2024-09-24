# Действие DeleteEndpoint

Удаляет [эндпоинт для Push-уведомлений](../concepts/index.md#mobile-endpoints).

## HTTP-запрос {#request}

```http
POST https://{{ cns-host }}/
```

### Query-параметры {#parameters}

Параметр | Описание
--- | ---
`Action` | **string**<br/>Обязательное поле.<br/>Параметр для обозначения типа операции.<br/>Значение: `DeleteEndpoint`.
`EndpointArn` | **string**<br/>Обязательное поле.<br/>Идентификатор (ARN) мобильного эндпоинта.<br/>Пример: `arn:aws:sns::aoegtvhtp8ob********:endpoint/GCM/test-cns-9990/4cbe148515360244248c993abe0a12884d162bb15e87d6c16bd0c810********`.
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
  <DeleteEndpointResponse>
	  <ResponseMetadata>
		  <RequestId>string</RequestId>
	  </ResponseMetadata>
  </DeleteEndpointResponse>
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

При возникновении ошибки {{ cns-name }} отвечает сообщением с соответствующим HTTP-кодом.

Перечень общих кодов ошибок для всех действий см. в разделе [{#T}](common-errors.md).

## См. также {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)
* [API action DeleteEndpoint](https://docs.aws.amazon.com/sns/latest/api/API_DeleteEndpoint.html) в документации AWS.
