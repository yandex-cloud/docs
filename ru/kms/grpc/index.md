# Yandex KMS API
Методы справочника API сгруппированы по ресурсам. Чтобы выполнить операцию над ресурсом, отправьте HTTP-запрос к соответствующему URL. Подробнее об архитектуре API Яндекс.Облака, см. [Концепции API Яндекс.Облака](/docs/api-design-guide/).

Спецификации API Яндекс.Облака смотрите на [GitHub](https://github.com/yandex-cloud/cloudapi).

Сервис | Описание
--- | ---
[SymmetricCryptoService](./symmetric_crypto_service.md) | --- Data plane for KMS symmetric cryptography operations Набор методов, выполняющих симметричное шифрование и дешифрование.
[SymmetricKeyService](./symmetric_key_service.md) | Набор методов для управления симметричными ключами KMS.
[OperationService](./operation_service.md) | Набор методов для управления операциями в асинхронных запросах API. Ссылки указаны относительно домена `operation.api.cloud.yandex.net`.
