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