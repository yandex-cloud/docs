# Yandex Lockbox API
Методы справочника API сгруппированы по ресурсам. Чтобы выполнить операцию над ресурсом, отправьте HTTP-запрос к соответствующему URL. Подробнее об архитектуре API Яндекс.Облака, см. [Концепции API Яндекс.Облака](/docs/api-design-guide/).

Спецификации API Яндекс.Облака смотрите на [GitHub](https://github.com/yandex-cloud/cloudapi).

Сервис | Описание
--- | ---
[PayloadService](./payload_service.md) | Набор методов доступа к содержимому секретов.
[SecretService](./secret_service.md) | Набор методов для управления секретами.
[OperationService](./operation_service.md) | Набор методов для управления операциями в асинхронных запросах API. Ссылки указаны относительно домена `operation.api.cloud.yandex.net`.
