[Документация Yandex Cloud](../index.md) > [Yandex DataLens](index.md) > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Audit Trails

В Audit Trails для Yandex DataLens поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.datalens.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`CopyEntriesToWorkbook` | Копирование объекта в [воркбук](workbooks-collections/index.md). Объект (`Entry`) — общее обозначение для [подключений](concepts/connection/index.md), [датасетов](dataset/index.md), [чартов](concepts/chart/index.md), [дашбордов](concepts/dashboard.md), [отчетов](reports/index.md) и папок
`CopyEntry` | Копирование объекта
`CopyTemplate` | Разворачивание продукта
`CopyWorkbook` | Копирование воркбука
`CreateCollection` | Создание [коллекции](workbooks-collections/index.md)
`CreateColorPalette` | Создание [цветовой палитры](operations/chart/create-palette.md)
`CreateEmbed` | Создание встраивания
`CreateEmbeddingSecret` | Создание ключа для [встраивания](security/embedded-objects.md)
`CreateEntityBinding` | Создание привязки [общего объекта](security/workbooks-access-advanced.md) в воркбуке
`CreateEntry` | Создание объекта
`CreateWorkbook` | Создание воркбука
`DeleteCollections` | Удаление коллекций
`DeleteColorPalette` | Удаление цветовой палитры
`DeleteEmbed` | Удаление встраивания
`DeleteEmbeddingSecret` | Удаление ключа для встраивания
`DeleteEntityBinding` | Удаление привязки общего объекта из воркбука
`DeleteEntry` | Удаление объекта
`DeleteSharedEntry` | Удаление общего объекта
`DeleteWorkbooks` | Удаление одного или нескольких воркбуков
`platform.CreateAirflowCluster` | Создание кластера Airflow
`platform.CreateCloudEnvironment` | Создание облачного окружения
`platform.CreateRestCatalog` | Создание REST-каталога
`platform.CreateRestCatalogNamespace` | Создание пространства имен REST-каталога
`platform.CreateSparkCluster` | Создание кластера Spark
`platform.CreateTrinoCluster` | Создание кластера Trino
`platform.DeleteAirflowCluster` | Удаление кластера Airflow
`platform.DeleteCloudEnvironment` | Удаление облачного окружения
`platform.DeleteRestCatalog` | Удаление REST-каталога
`platform.DeleteRestCatalogNamespace` | Удаление пространства имен REST-каталога
`platform.DeleteSparkCluster` | Удаление кластера Spark
`platform.DeleteTrinoCluster` | Удаление кластера Trino
`platform.UpdateCloudEnvironment` | Изменение облачного окружения
`DisableBillingInstanceService` | Получение сигнала от Yandex Cloud Billing о неактивности привязанного к DataLens платежного аккаунта
`DisableFolders` | [Отключение](settings/navigation.md#disable-folder-navigation) навигации по папкам
`DisableTenantBilling` | Планирование отключения тарифа Business пользователем в начале следующего месяца ^1^
`EnableBillingInstanceService` | Получение сигнала от Yandex Cloud Billing об активности привязанного к DataLens [платежного аккаунта](../billing/concepts/billing-account.md)
`EnableTenantBilling` | Включение пользователем тарифа Business ^1^
`FolderEntryBatchModifyPermissions` | Массовое изменение настроек доступа к папочным объектам
`FolderEntryModifyPermissions` | Изменение настроек доступа к папочным объектам
`MigrateEntriesToWorkbook` | Миграция объектов в воркбук
`MoveCollections` | Перемещение коллекций
`MoveEntry` | Перемещение объекта
`MoveSharedEntry` | Перемещение общего объекта
`MoveWorkbooks` | Перемещение воркбуков
`RenameEntry` | Переименование объекта
`SetDefaultColorPalette` | Настройка цветовой палитры по умолчанию
`SwitchAiAssistantProhibition` | Изменение запрета на использование Нейроаналитика
`SwitchDataExportProhibition` | Изменение запрета на экспорт данных
`SwitchEntriesPublicationStatus` | Изменение статуса публикации объекта
`SwitchPublicationProhibition` | Изменение запрета на публикацию объектов
`SwitchWorkbookFileExportProhibition` | Изменение запрета на экспорт файлов из воркбука
`UpdateCollection` | Изменение коллекции
`UpdateCollectionAccessBindings` | Изменение настроек доступа к коллекции
`UpdateColorPalette` | Изменение цветовой палитры
`UpdateEmbed` | Изменение встраивания
`UpdateEntityBinding` | Редактирование привязки общего объекта в воркбуке
`UpdateEntry` | Изменение объекта
`UpdateSharedEntryAccessBindings` | Изменение настроек доступа к общему объекту
`UpdateTenantAccessBindings` | Изменение прав доступа к инстансу DataLens
`UpdateWorkbook` | Изменение воркбука
`UpdateWorkbookAccessBindings` | Изменение настроек доступа к воркбуку

^1^ С 1 декабря 2025 года события больше не передаются в связи с прекращением действия [тарифа Business](pricing-changes.md).