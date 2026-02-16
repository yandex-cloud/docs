```php
$response = $client->createPlatformApplication(
    [
        'Name' => '<имя_канала>',
        'Platform' => '<тип_платформы>',
        'Attributes' => [
            '<параметр1>' => '<значение1>',
            ...
            '<параметрN>' => '<значениеN>'
        ],
    ]
);

print($response->get('PlatformApplicationArn'));
```

Где:

* `Name` — имя канала уведомлений, задается пользователем.
  
  {% include [channel-name](../../_includes/notifications/channel-name.md) %}

* `Platform` — тип мобильной платформы:

  {% include [platform-types](../../_includes/notifications/platform-types.md) %}

* `Attributes` — параметры аутентификации на мобильной платформе в формате `'<параметр1>' => '<значение1>'` через запятую. Значения зависят от типа платформы:

  * APNs:

    * Аутентификация с токеном:

      * `PlatformPrincipal` — путь к файлу с ключом подписи токена, полученный в Apple.
      * `PlatformCredential` — идентификатор ключа подписи (Key ID).
      * `ApplePlatformTeamID` — идентификатор разработчика (Team ID).
      * `ApplePlatformBundleID` — идентификатор приложения (Bundle ID).

    * Аутентификация с сертификатом:

      * `PlatformPrincipal` — SSL-сертификат в формате `.pem`.
      * `PlatformCredential` — закрытый ключ сертификата в формате `.pem`.

          {% include [convert-p12-to-pem](convert-p12-to-pem.md) %}

    Аутентификация с токеном — более современный и безопасный метод.

  * FCM: `PlatformCredential` — ключ сервисного аккаунта Google Cloud в формате JSON для аутентификации с помощью HTTP v1 API или API-ключ (server key) для аутентификации с помощью Legacy API.

    Используйте HTTP v1 API, так как с июля 2024 года [FCM legacy API не поддерживается](https://firebase.google.com/docs/cloud-messaging/migrate-v1).

  * HMS:

    * `PlatformPrincipal` — идентификатор ключа.
    * `PlatformCredential` — API-ключ.
  
  * RuStore:
  
    * `PlatformPrincipal` — идентификатор проекта (ProjectID).
    * `PlatformCredential` — сервисный токен (ServiceToken).

В результате вы получите идентификатор (ARN) канала уведомлений.