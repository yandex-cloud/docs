# Действие SetEndpointAttributes

Задает атрибуты [эндпоинта для Push-уведомлений](../concepts/index.md#mobile-endpoints).

## HTTP-запрос {#request}

```http
POST https://{{ cns-host }}/
```

### Query-параметры {#parameters}

Параметр | Описание
--- | ---
`Action` | **string**<br/>Обязательное поле.<br/>Параметр для обозначения типа операции.<br/>Значение: `SetEndpointAttributes`.
`EndpointArn` | **string**<br/>Обязательное поле.<br/>Идентификатор (ARN) эндпоинта.<br/>Пример: `arn:aws:sns::aoegtvhtp8ob********:endpoint/GCM/test-cns-9990/4cbe148515360244248c993abe0a12884d162bb15e87d6c16bd0c810********`.
`Attributes.entry.N.key` | **string**<br/>Обязательное поле.<br/>Ключ [атрибута](#attributes). `N` — числовое значение.<br/>Пример: `Attributes.entry.1.key=Token&Attributes.entry.2.key=CustomUserData`.
`Attributes.entry.N.value` | **string**<br/>Обязательное поле.<br/>Значение атрибута. `N` — числовое значение.<br/>Пример: `Attributes.entry.1.value=c8gzjriSVxDDzX2fAV********&Attributes.entry.2.value=test-text`.
`ResponseFormat` | **string**<br/>Формат ответа.<br/>Возможные значения:<ul><li>`XML` (по умолчанию).</li><li>`JSON`.</li></ul>

### Атрибуты {#attributes}

Атрибут | Описание
--- | ---
`Token` | **string**<br/>Обязательное поле.<br/>Для мобильных уведомлений — уникальный токен на устройстве пользователя (Registration ID), созданный сервисом уведомлений для приложения. Для уведомлений в браузере — объект [PushSubscription](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription) в формате [JSON](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription/toJSON), который получен в браузере пользователя.
`CustomUserData` | **string**<br/>Прочие пользовательские данные, которые можно сохранить вместе с эндпоинтом. {{ cns-name }} никак не использует эти данные.

{% note info %}

Атрибут `Enabled` (включение и выключение уведомлений в эндпоинт) в настоящее время не поддерживается. 

{% endnote %}

## Ответ {#response}

### Успешный ответ {#response-200}

При отсутствии ошибок {{ cns-name }} отвечает HTTP-кодом `200`.

Успешный ответ содержит дополнительные данные в формате XML или JSON в зависимости от указанного параметра `ResponseFormat`.

Схема данных:

{% list tabs %}

- XML

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <SetEndpointAttributesResponse>
	  <ResponseMetadata>
		  <RequestId>string</RequestId>
	  </ResponseMetadata>
  </SetEndpointAttributesResponse>
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
* [API action SetEndpointAttributes](https://docs.aws.amazon.com/sns/latest/api/API_SetEndpointAttributes.html) в документации AWS.
