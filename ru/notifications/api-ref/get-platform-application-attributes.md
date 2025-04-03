# Действие GetPlatformApplicationAttributes

Получает параметры [канала мобильных Push-уведомлений](../concepts/push.md) или [Push-уведомлений в браузере](../concepts/browser.md).

## HTTP-запрос {#request}

```http
POST https://{{ cns-host }}/
```

### Query-параметры {#parameters}

Параметр | Описание
--- | ---
`Action` | **string**<br/>Обязательное поле.<br/>Параметр для обозначения типа операции.<br/>Значение: `GetPlatformApplicationAttributes`.
`PlatformApplicationArn` | **string**<br/>Обязательное поле.<br/>Идентификатор канала Push-уведомлений.<br/>Пример: `arn:aws:sns::aoegtvhtp8ob********:app/GCM/test-cns-9990`.
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
  <GetPlatformApplicationAttributesResponseXML>
	  <ResponseMetadata>
		  <RequestId>string</RequestId>
	  </ResponseMetadata>
	  <GetPlatformApplicationAttributesResult>
		  <Attributes>
			  <entry>
				  <key>string</key>
				  <value>string</value>
			  </entry>
		  </Attributes>
	  </GetPlatformApplicationAttributesResult>
  </GetPlatformApplicationAttributesResponseXML>
  ```

  Где:
  * `RequestId` — идентификатор запроса.
  * `Attributes` — атрибуты канала уведомлений. Поддерживается вывод следующих атрибутов:
    * `ApplePlatformTeamID` — идентификатор разработчика, только при использовании токена.
    * `ApplePlatformBundleID` — идентификатор приложения (Bundle ID), только при использовании токена.
    * `AppleCertificateExpiryDate` — дата истечения срока действия сертификата, только при использовании сертификата.

- JSON

  ```json
  {
    "ResponseMetadata": {
      "RequestId": "string"
    },
    "GetPlatformApplicationAttributesResult": {
      "Attributes": {
        "Attribute": "string"
      }
    }
  }
  ```

  Где:
  * `RequestId` — идентификатор запроса.
  * `Attributes` — атрибуты канала уведомлений. Поддерживается вывод следующих атрибутов:
    * `ApplePlatformTeamID` — идентификатор разработчика, только при использовании токена.
    * `ApplePlatformBundleID` — идентификатор приложения (Bundle ID), только при использовании токена.
    * `AppleCertificateExpiryDate` — дата истечения срока действия сертификата, только при использовании сертификата.
    * `Name` — имя канала мобильных Push-уведомлений.
    * `Description` — описание канала мобильных Push-уведомлений.
    * `Platform` — платформа для отправки мобильных Push-уведомлений:
      * `APNS` — [Apple Push Notification service](https://developer.apple.com/notifications/).
      * `APNS_SANDBOX` — Apple Push Notification service для тестирования приложения.
      * `FCM` — [Firebase Cloud Messaging](https://firebase.google.com/).
      * `HMS` — [Huawei Mobile Services](https://developer.huawei.com/consumer/).
      * `WEB` — [Push-уведомления в браузере](https://developer.mozilla.org/en-US/docs/Web/API/Push_API).
    * `CreatedAt` — дата и время создания канала мобильных Push-уведомлений.

{% endlist %}

### Ответ с ошибкой {#response-4xx}

При возникновении ошибки {{ cns-name }} отвечает сообщением с соответствующим HTTP-кодом.

Перечень общих кодов ошибок для всех действий см. в разделе [{#T}](common-errors.md).

## См. также {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)
* [API action GetPlatformApplicationAttributes](https://docs.aws.amazon.com/sns/latest/api/API_GetPlatformApplicationAttributes.html) в документации AWS.
