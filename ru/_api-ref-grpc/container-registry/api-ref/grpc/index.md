# Yandex Container Registry API
Чтобы выполнить операцию над ресурсом выполните RPC-вызов. Используйте домен `container-registry.api.cloud.yandex.net` для выполнения запросов к API. Подробнее об архитектуре API Яндекс.Облака, см. [Концепции API Яндекс.Облака](/docs/api-design-guide/).

Спецификации API Яндекс.Облака смотрите на [GitHub](https://github.com/yandex-cloud/cloudapi).

Сервис | Описание
--- | ---
[ImageService](./image_service.md) | Набор методов для управления ресурсами Image.
[RegistryService](./registry_service.md) | Набор методов для управления ресурсами Registry.
[RepositoryService](./repository_service.md) | Набор методов для управления ресурсами Repository.
[OperationService](./operation_service.md) | Набор методов для управления операциями в асинхронных запросах API. Ссылки указаны относительно домена `operation.api.cloud.yandex.net`.
