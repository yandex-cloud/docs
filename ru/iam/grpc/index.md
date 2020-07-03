# Yandex IAM API
Методы справочника API сгруппированы по ресурсам. Чтобы выполнить операцию над ресурсом выполните RPC-вызов. Подробнее об архитектуре API Яндекс.Облака, см. [Концепции API Яндекс.Облака](/docs/api-design-guide/).

Спецификации API Яндекс.Облака смотрите на [GitHub](https://github.com/yandex-cloud/cloudapi).

Сервис | Описание
--- | ---
[ApiKeyService](./api_key_service.md) | Набор методов управления API-ключами.
[IamTokenService](./iam_token_service.md) | Набор методов для управления IAM-токенами.
[KeyService](./key_service.md) | Набор методов для управления ресурсами Key.
[RoleService](./role_service.md) | Набор методов для управления ресурсами Role.
[ServiceAccountService](./service_account_service.md) | Набор методов для управления ресурсами ServiceAccount.
[UserAccountService](./user_account_service.md) | Набор методов управления пользовательскими аккаунтами. Сейчас используется только для [аккаунтов Яндекс.Паспорта](/docs/iam/concepts/#passport).
[YandexPassportUserAccountService](./yandex_passport_user_account_service.md) | Набор методов для управления ресурсами YandexPassportUserAccount.
[AccessKeyService](./access_key_service.md) | Набор методов управления ключами доступа.
[CertificateService](./certificate_service.md) | Набор методов для управления сертификатами.
[FederationService](./federation_service.md) | Набор методов для управления федерациями.
[OperationService](./operation_service.md) | Набор методов для управления операциями в асинхронных запросах API. Ссылки указаны относительно домена `operation.api.cloud.yandex.net`.
