# Yandex Cloud Functions Service
Чтобы выполнить операцию над ресурсом выполните RPC-вызов. Используйте домен `serverless-functions.api.cloud.yandex.net` для выполнения запросов к API. Подробнее об архитектуре API Яндекс.Облака, см. [Концепции API Яндекс.Облака](/docs/api-design-guide/).

Спецификации API Яндекс.Облака смотрите на [GitHub](https://github.com/yandex-cloud/cloudapi).

Сервис | Описание
--- | ---
[FunctionService](./function_service.md) | Набор методов управления бессерверными функциями.
[OperationService](./operation_service.md) | Набор методов для управления операциями в асинхронных запросах API. Ссылки указаны относительно домена `operation.api.cloud.yandex.net`.
