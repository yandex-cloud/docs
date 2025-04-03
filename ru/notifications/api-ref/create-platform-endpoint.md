# Действие CreatePlatformEndpoint

Создает [эндпоинт для Push-уведомлений](../concepts/index.md#mobile-endpoints) (подписывает пользователя на Push-уведомления).

## HTTP-запрос {#request}

```http
POST https://{{ cns-host }}/
```

### Query-параметры {#parameters}

Параметр | Описание
--- | ---
`Action` | **string**<br/>Обязательное поле.<br/>Параметр для обозначения типа операции.<br/>Значение: `CreatePlatformEndpoint`.
`PlatformApplicationArn` | **string**<br/>Обязательное поле.<br/>Идентификатор канала мобильных Push-уведомлений или Push-уведомлений в браузере.<br/>Пример: `arn:aws:sns::aoegtvhtp8ob********:app/GCM/test-cns-9990`.
`Token` | **string**<br/>Обязательное поле.<br/>Для мобильных уведомлений — уникальный токен на устройстве пользователя (Registration ID), созданный сервисом уведомлений для приложения. Для уведомлений в браузере — объект [PushSubscription](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription) в формате [JSON](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription/toJSON), который получен в браузере пользователя.
`CustomUserData` | **string**<br/>Прочие пользовательские данные, которые можно сохранить вместе с эндпоинтом. {{ cns-name }} никак не использует эти данные.
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
  <CreatePlatformEndpointResponse>
	  <ResponseMetadata>
		  <RequestId>string</RequestId>
	  </ResponseMetadata>
	  <EndpointArn>string</EndpointArn>
  </CreatePlatformEndpointResponse>
  ```

- JSON

  ```json
  {
    "ResponseMetadata": {
      "RequestId": "string"
    },
    "EndpointArn": "string"
  }
  ```

{% endlist %}

Где:
* `RequestId` — идентификатор запроса.
* `EndpointArn` — идентификатор (ARN) мобильного эндпоинта.

### Ответ с ошибкой {#response-4xx}

При возникновении ошибки {{ cns-name }} отвечает сообщением с соответствующим HTTP-кодом.

Перечень общих кодов ошибок для всех действий см. в разделе [{#T}](common-errors.md).

## См. также {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)
* [API action CreatePlatformEndpoint](https://docs.aws.amazon.com/sns/latest/api/API_CreatePlatformEndpoint.html) в документации AWS.
