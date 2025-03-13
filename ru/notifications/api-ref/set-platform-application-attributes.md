# Действие SetPlatformApplicationAttributes

Задать параметры [канала мобильных Push-уведомлений](../concepts/push.md).

## HTTP-запрос {#request}

```http
POST https://{{ cns-host }}/
```

### Query-параметры {#parameters}

Параметр | Описание
--- | ---
`Action` | **string**<br/>Обязательное поле.<br/>Параметр для обозначения типа операции.<br/>Значение: `SetPlatformApplicationAttributes`.
`PlatformApplicationArn` | **string**<br/>Обязательное поле.<br/>Идентификатор канала мобильных Push-уведомлений.<br/>Пример: `arn:aws:sns::aoegtvhtp8ob********:app/GCM/test-cns-9990`.
`Attributes.entry.N.key` | **string**<br/>Обязательное поле.<br/>Ключ [атрибута](#attributes). `N` — числовое значение.<br/>Пример: `Attributes.entry.1.key=PlatformPrincipal&Attributes.entry.2.key=PlatformCredential`.
`Attributes.entry.N.value` | **string**<br/>Обязательное поле.<br/>Значение атрибута. `N` — числовое значение.<br/>Пример: `Attributes.entry.1.value=c8gzjriSVxDDzX2fAV********&Attributes.entry.2.value=CgB6e3x9iW/qiE9l9wAUPK0e/bJQe5uIgTlYUD4bP********`.
`ResponseFormat` | **string**<br/>Формат ответа.<br/>Возможные значения:<ul><li>`XML` (по умолчанию).</li><li>`JSON`.</li></ul>

### Атрибуты {#attributes}

#### Общие атрибуты {#attributes-common}

Атрибут | Описание
--- | ---
`Description` | **string**<br/>Описание приложения.<br/>Пример: `Test application`.

#### Атрибуты APNS и APNS_SANDBOX {#attributes-apns}

Атрибут | Описание
--- | ---
`PlatformPrincipal` | **string**<br/>Токен в формате `.p8` или SSL-сертификат в формате `.p12`. Аутентификация с токеном является предпочтительной, как более современная.
`PlatformCredential` | **string**<br/>Идентификатор токена или закрытый ключ SSL-сертификата.
`ApplePlatformTeamID` | **string**<br/>Идентификатор разработчика, только при использовании токена.
`ApplePlatformBundleID` | **string**<br/>Идентификатор приложения (Bundle ID), только при использовании токена.

#### Атрибуты FCM {#attributes-fcm}

Атрибут | Описание
--- | ---
`PlatformCredential` | **string**<br/>Ключ сервисного аккаунта Google Cloud в формате JSON для аутентификации с помощью HTTP v1 API или API-ключ (server key) для аутентификации с помощью Legacy API. Версия HTTP v1 API является предпочтительной, так как с июня 2024 года Legacy API [не будет поддерживаться FCM](https://firebase.google.com/docs/cloud-messaging/migrate-v1).

#### Атрибуты HMS {#attributes-hms}

Атрибут | Описание
--- | ---
`PlatformPrincipal` | **string**<br/>Идентификатор ключа.
`PlatformCredential` | **string**<br/>API-ключ.

#### Атрибуты RUSTORE {#attributes-rustore}

Атрибут | Описание
--- | ---
`PlatformPrincipal` | **string**<br/>Идентификатор проекта.
`PlatformCredential` | **string**<br/>Сервисный токен.

Подробнее об атрибутах для аутентификации см. в подразделе [Каналы мобильных Push-уведомлений](../concepts/push.md).

## Ответ {#response}

### Успешный ответ {#response-200}

При отсутствии ошибок {{ cns-name }} отвечает HTTP-кодом `200`.

Успешный ответ содержит дополнительные данные в формате XML или JSON в зависимости от указанного параметра `ResponseFormat`.

Схема данных:

{% list tabs %}

- XML

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <SetPlatformApplicationAttributes>
	  <ResponseMetadata>
		  <RequestId>string</RequestId>
	  </ResponseMetadata>
  </SetPlatformApplicationAttributes>
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
* [API action SetPlatformApplicationAttributes](https://docs.aws.amazon.com/sns/latest/api/API_SetPlatformApplicationAttributes.html) в документации AWS.
