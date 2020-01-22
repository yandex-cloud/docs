# Yandex Resource Management API
Чтобы выполнить операцию над ресурсом выполните RPC-вызов. Используйте домен `resource-manager.api.cloud.yandex.net` для выполнения запросов к API. Подробнее об архитектуре API Яндекс.Облака, см. [Концепции API Яндекс.Облака](/docs/api-design-guide/).

Спецификации API Яндекс.Облака смотрите на [GitHub](https://github.com/yandex-cloud/cloudapi).

Сервис | Описание
--- | ---
[CloudService](./cloud_service.md) | Набор методов для управления ресурсом Cloud.
[FolderService](./folder_service.md) | Набор методов для управления ресурсом Folder.
[OperationService](./operation_service.md) | Набор методов для управления операциями в асинхронных запросах API. Ссылки указаны относительно домена `operation.api.cloud.yandex.net`.
