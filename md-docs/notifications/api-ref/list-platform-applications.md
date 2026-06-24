# Действие ListPlatformApplications

Получает список [каналов мобильных Push-уведомлений](../concepts/push.md) или [Push-уведомлений в браузере](../concepts/browser.md). Действие всегда выдает одну страницу и не поддерживает пагинацию.

## HTTP-запрос {#request}

```http
POST https://notifications.yandexcloud.net/
```

### Query-параметры {#parameters}

Параметр | Описание
--- | ---
`Action` | **string**<br/>Обязательное поле.<br/>Параметр для обозначения типа операции.<br/>Значение: `ListPlatformApplications`.
`FolderId` | **string**<br/>Обязательное поле.<br/>[Идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором размещены каналы уведомлений.<br/>Пример: `b1gsm0k26v1l********`.
`ResponseFormat` | **string**<br/>Формат ответа.<br/>Возможные значения:<ul><li>`XML` (по умолчанию).</li><li>`JSON`.</li></ul>

## Ответ {#response}

### Успешный ответ {#response-200}

При отсутствии ошибок Cloud Notification Service отвечает HTTP-кодом `200`.

Успешный ответ содержит дополнительные данные в формате XML или JSON в зависимости от указанного параметра `ResponseFormat`.

Схема данных:

{% list tabs %}

- XML

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <ListPlatformApplicationsResponseXML>
	  <ResponseMetadata>
		  <RequestId>string</RequestId>
	  </ResponseMetadata>
	  <ListPlatformApplicationsResult>
		  <PlatformApplications>
			  <member>
				  <PlatformApplicationARN>string</PlatformApplicationARN>
				  <Attributes>
					  <entry>
						  <key>string</key>
						  <value>string</value>
					  </entry>
				  </Attributes>
			  </member>
		  </PlatformApplications>
	  </ListPlatformApplicationsResult>
  </ListPlatformApplicationsResponseXML>
  ```

  Где:
  * `RequestId` — идентификатор запроса.
  * `PlatformApplicationArn` — идентификатор (ARN) канала уведомлений.
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
    "ListPlatformApplicationsResult": {
      "PlatformApplications": [
        {
          "PlatformApplicationARN": "string",
          "Attributes": {
            "Attribute": "string"
          }
        }
      ]
    }
  }
  ```

  Где:
  * `RequestId` — идентификатор запроса.
  * `PlatformApplicationArn` — идентификатор (ARN) канала уведомлений.
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
    * `CreatedAt` — дата и время создания канала мобильных Push-уведомлений.

{% endlist %}

### Ответ с ошибкой {#response-4xx}

При возникновении ошибки Cloud Notification Service отвечает сообщением с соответствующим HTTP-кодом.

Перечень общих кодов ошибок для всех действий приведен в разделе [Ошибки](common-errors.md).

#### Полезные ссылки {#see-also}

* [Обзор HTTP API Yandex Cloud Notification Service](index.md)
* [Отправить запрос HTTP API к Yandex Cloud Notification Service](send-request.md)
* [API action ListPlatformApplications](https://docs.aws.amazon.com/sns/latest/api/API_ListPlatformApplications.html) в документации AWS