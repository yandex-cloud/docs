# Yandex Managed Service for ClickHouse API
Чтобы выполнить операцию над ресурсом выполните RPC-вызов. Используйте домен `mdb.api.cloud.yandex.net` для выполнения запросов к API. Подробнее об архитектуре API Яндекс.Облака, см. [Концепции API Яндекс.Облака](/docs/api-design-guide/).

Спецификации API Яндекс.Облака смотрите на [GitHub](https://github.com/yandex-cloud/cloudapi).

Сервис | Описание
--- | ---
[BackupService](./backup_service.md) | Набор методов для управления резервными копиями для ClickHouse.
[ClusterService](./cluster_service.md) | Набор методов для управления кластерами ClickHouse.
[DatabaseService](./database_service.md) | Набор методов для управления ресурсами Database для ClickHouse.
[ResourcePresetService](./resource_preset_service.md) | Набор методов для управления ресурсами ResourcePreset.
[UserService](./user_service.md) | Набор методов для управления ресурсами User для ClickHouse.
[OperationService](./operation_service.md) | Набор методов для управления операциями в асинхронных запросах API. Ссылки указаны относительно домена `operation.api.cloud.yandex.net`.
