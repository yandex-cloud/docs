# Действие ListEndpointsByPlatformApplication

Получает список [эндпоинтов для Push-уведомлений](../concepts/index.md#mobile-endpoints).

## HTTP-запрос {#request}

```http
POST https://{{ cns-host }}/
```

### Query-параметры {#parameters}

Параметр | Описание
--- | ---
`Action` | **string**<br/>Обязательное поле.<br/>Параметр для обозначения типа операции.<br/>Значение: `ListEndpointsByPlatformApplication`.
`PlatformApplicationArn` | **string**<br/>Обязательное поле.<br/>Идентификатор канала мобильных Push-уведомлений.<br/>Пример: `arn:aws:sns::aoegtvhtp8ob********:app/GCM/test-cns-9990`.
`NextToken` | **string**<br/>Токен для просмотра записей об эндпоинтах после первой страницы.
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
  <ListEndpointsByPlatformApplicationResponseXML>
	  <ResponseMetadata>
		  <RequestId>string</RequestId>
	  </ResponseMetadata>
	  <ListEndpointsByPlatformApplicationResult>
		  <Endpoints>
			  <member>
				  <EndpointArn>string</EndpointArn>
				  <Attributes>
					  <entry>
						  <key>string</key>
						  <value>string</value>
					  </entry>
				  </Attributes>
			  </member>
		  </Endpoints>
		  <NextToken>string</NextToken>
	  </ListEndpointsByPlatformApplicationResult>
  </ListEndpointsByPlatformApplicationResponseXML>
  ```

- JSON

  ```json
  {
    "ResponseMetadata": {
      "RequestId": "string"
    },
    "ListEndpointsByPlatformApplicationResult": {
      "Endpoints": [
        {
          "EndpointARN": "string",
          "Attributes": {
            "Attribute": "string"
          }
        }
      ],
      "NextToken": "string"
    }
  }
  ```

{% endlist %}

Где:
* `RequestId` — идентификатор запроса.
* `EndpointArn` — идентификатор (ARN) мобильного эндпоинта.
* `Attributes` — атрибуты мобильного эндпоинта. Поддерживается вывод следующих атрибутов:
  * `CustomUserData` — прочие пользовательские данные, которые хранятся вместе с эндпоинтом. {{ cns-name }} никак не использует эти данные.
  * `Enabled` — атрибут для включение и выключение уведомлений в эндпоинт, в настоящее время не поддерживается. Всегда возвращается значение `true`.

  {% note info %}

  Вывод атрибута `Token` не осуществляется для дополнительной защиты данных.

  {% endnote %}
* `NextToken` — токен для просмотра записей об эндпоинтах на следующей странице. Возвращается, когда доступны дополнительные записи. Если все записи были просмотрены, `NextToken` не возвращается.

### Ответ с ошибкой {#response-4xx}

При возникновении ошибки {{ cns-name }} отвечает сообщением с соответствующим HTTP-кодом.

Перечень общих кодов ошибок для всех действий см. в разделе [{#T}](common-errors.md).

## См. также {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)
* [API action ListEndpointsByPlatformApplication](https://docs.aws.amazon.com/sns/latest/api/API_ListEndpointsByPlatformApplication.html) в документации AWS.
