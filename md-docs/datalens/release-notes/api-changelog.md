[Документация Yandex Cloud](../../index.md) > [Yandex DataLens](../index.md) > DataLens Public API > История изменений

# История изменений Public API в Yandex DataLens

В этом разделе собрана история изменений DataLens Public API. Подробнее про версионирование в [документации](../operations/api-versioning.md).

## Версия 3 {#version-3}



### Сентябрь 2026 {#02092026}

Совместимые изменения в Public API версии 3.


1. Добавили заголовки ответа:

   * `x-dl-api-stable-version` — номер новой стабильной версии;
   * `deprecation` — наличие заголовка означает, что версия, через которую обращается пользователь, устарела. Содержит `unix-timestamp` даты выхода новой версии.
   
   Пример:

   ```bash
   x-dl-api-stable-version: 3
   deprecation: @1788825600
   ```

1. В метод [getEntries](https://api.datalens.tech/#/Navigation/post_rpc_getEntries):
   
   * добавили поле `scopes`;
   * для поля `type` изменили тип данных: `string` → `string | string[]`, где `string[]` — массив из 1–10 элементов.

1. В метод [getWorkbookEntries](https://api.datalens.tech/#/Workbook/post_rpc_getWorkbookEntries) добавили значение `scope` в `orderBy.field`.
1. В схемах чартов в Editor добавили `data.activities` для [таблиц](../charts/editor/widgets/table.md), [Gravity UI Charts](../charts/editor/widgets/gravity-ui.md) и [JS-селекторов](../charts/editor/widgets/controls.md).
1. В метод [getTenantDetails](https://api.datalens.tech/#/Tenants/post_rpc_getTenantDetails) добавили ответ с полями: `tenantId`, `orgId`, `settings`, `dlpEnabled`, `foldersEnabled`.
1. Актуализировали подключения:

   * Добавили поле `ai_access_level`.
   * Уточнили схемы создания, чтения и частичного обновления: обязательность полей, допустимость `null` и значения перечислений.
   * В схеме ответа `createConnection` добавили необязательное поле `operation`.
   * добавили поля `dlp_managed_*`, `mode`, `variant` в подключения [ClickHouse®](../operations/connection/create-clickhouse.md), [MySQL®](../operations/connection/create-mysql.md) и [PostgreSQL](../operations/connection/create-postgresql.md).
   * Для подключения [Trino](../operations/connection/create-trino.md) добавили поля `extra_credentials`,`cluster_entry_id` и `form_fill_mode`.

1. Актуализировали датасеты:
      
   * В схемах `DatasetCreate`, `DatasetRead`, `DatasetUpdate` добавили поля `publishedId`, `revId`, `savedId`.
   * В `DatasetUpdate` добавили поле `mode` со значениями `save` и `publish` (по умолчанию).
   * Расширили схемы источников и параметров запросов.


1. Добавили новые методы для работы в [DataLens Platform](../datalens-platform/index.md) со следующими объектами:

   * [REST-каталоги](https://api.datalens.tech/#/RestCatalogs);
   * кластеры [Apache Spark™](https://api.datalens.tech/#/SparkClusters) и [Trino](https://api.datalens.tech/#/TrinoClusters);
   * [SQL-запросы](https://api.datalens.tech/#/SqlQueries);
   * [окружения](https://api.datalens.tech/#/CloudEnvironments);
   * [бакеты](https://api.datalens.tech/#/CloudEnvironmentStorage).



1. Добавили метод [getHtmlPagePreviewUrl](https://api.datalens.tech/#/HtmlPages/post_rpc_getHtmlPagePreviewUrl).
1. В методе [getHtmlPage](https://api.datalens.tech/#/HtmlPages/post_rpc_getHtmlPage) добавили поддержку аудитного режима.
1. В методе [getPermissions](https://api.datalens.tech/#/Folder/post_rpc_getPermissions) стали необязательными в ответе поля: `approver`, `description`, `extras`, `requester`.





### 08.09.2026 — переход на версию 3 {#08092026}


1. Изменили схему аргументов/ответа методов для работы с чартами в визарде:

   * [getWizardChart](https://api.datalens.tech/#/HtmlPages/post_rpc_getWizardChart)
   * [createWizardChart](https://api.datalens.tech/#/HtmlPages/post_rpc_createWizardChart)
   * [updateWizardChart](https://api.datalens.tech/#/HtmlPages/post_rpc_updateWizardChart)
   
1. Изменили методы для работы с дашбордами и отчетами:

   * Добавили v2-версии методов получения, создания и обновления дашбордов и отчетов:
     
     * [getDashboardV2](https://api.datalens.tech/#/HtmlPages/post_rpc_getDashboardV2)
     * [createDashboardV2](https://api.datalens.tech/#/HtmlPages/post_rpc_createDashboardV2)
     * [updateDashboardV2](https://api.datalens.tech/#/HtmlPages/post_rpc_updateDashboardV2)
     * [getPresentationV2](https://api.datalens.tech/#/HtmlPages/post_rpc_getPresentationV2)
     * [createPresentationV2](https://api.datalens.tech/#/HtmlPages/post_rpc_createPresentationV2)
     * [updatePresentationV2](https://api.datalens.tech/#/HtmlPages/post_rpc_updatePresentationV2)
     
   * Из схем удалили поля:
     
     * `schemeVersion` — служебное поле версии у дашбордов;
     * `data.version` — служебное поле версии у отчетов;
     * `data.description` — вместо этого поля теперь используется `annotation.description`;
     * `background` — устаревшее поле оформления;
     * `textColor` — устаревшее поле оформления;
     * `widgetTabId` — устаревшее поле инсайта на дашборде.

   * Для dataset-селекторов `fieldType` теперь принимает только значения из перечисления типов данных датасета, например `string`, `integer`, `date` и `genericdatetime`. Для manual-селекторов поле `fieldType` сохраняется только у селекторов даты.
   * Добавили условие, при котором у дашбордов обязателен хотя бы один таб в `data.tabs`.

1. Миграции (при получении через метод [getDashboardV2](https://api.datalens.tech/#/HtmlPages/post_rpc_getDashboardV2) или при сохранении в интерфейсе сущности v1):

   * Описание дашборда переносится из `data.description` в `annotation.description`.
   * Цвета фона всех виджетов переносятся из устаревшего `background` в `backgroundSettings.color: {light, dark}`, а цвет текста заголовка — из `textColor` в `textSettings.color: {light, dark}`. Конечный формат цвета — `HEX`.
   *  При отсутствии существующего актуального `widgetTabIds` при миграции `widgetTabId` перенесется в формате массива с одним элементом `widgetTabIds`.



## Версия 2 {#version-2}



### 28.07.2026 {#28072026}

Совместимые изменения в Public API версии 2.

1. Добавились методы для работы с HTML-страницами:

   * [createHtmlPage](https://api.datalens.tech/#/HtmlPages/post_rpc_createHtmlPage)
   * [deleteHtmlPage](https://api.datalens.tech/#/HtmlPages/post_rpc_deleteHtmlPage)
   * [getHtmlPage](https://api.datalens.tech/#/HtmlPages/post_rpc_getHtmlPage)
   * [updateHtmlPage](https://api.datalens.tech/#/HtmlPages/post_rpc_updateHtmlPage)

1. Добавили методы для управления блокировками редактирования сущностей DataLens (например, чартов, дашбордов и т. д.):

   * [createEntryLock](https://api.datalens.tech/#/EntryLock/post_rpc_createEntryLock)
   * [deleteEntryLock](https://api.datalens.tech/#/EntryLock/post_rpc_deleteEntryLock)
   * [extendEntryLock](https://api.datalens.tech/#/EntryLock/post_rpc_extendEntryLock)

1. Убрали тег `[Experimental]` с методов для работы с дашбордами:

   * [createDashboard](https://api.datalens.tech/#/Dashboard/post_rpc_createDashboard)
   * [deleteDashboard](https://api.datalens.tech/#/Dashboard/post_rpc_deleteDashboard)
   * [getDashboard](https://api.datalens.tech/#/Dashboard/post_rpc_getDashboard)
   * [updateDashboard](https://api.datalens.tech/#/Dashboard/post_rpc_updateDashboard)


### 15.06.2026 {#15062026}

Совместимые изменения в Public API версии 2. Добавились методы:

* [batchListMembers](https://api.datalens.tech/#/Access/post_rpc_batchListMembers)
* [deleteFolder](https://api.datalens.tech/#/Folder/post_rpc_deleteFolder)
* [dlsSuggest](https://api.datalens.tech/#/Folder/post_rpc_dlsSuggest)
* [getPermissions](https://api.datalens.tech/#/Folder/post_rpc_getPermissions)
* [modifyPermissions](https://api.datalens.tech/#/Folder/post_rpc_modifyPermissions)
* [moveFolderEntry](https://api.datalens.tech/#/Folder/post_rpc_moveFolderEntry)

### 11.06.2026 — переход на версию 2 {#11062026}

Несовместимые изменения с Public API версии 1. Изменилась версия Public API: теперь актуально Public API версии 2.

Несовместимое изменение затронуло метод `getEntries`, с помощью которого можно получать сущности Yandex DataLens.

1. Для поля `ids` изменился тип данных: `string | string[]` → `string[]`.
1. Для поля `createdBy` изменился тип данных: `string | string[]` → `string[]`.
1. Поле `page` с типом `number` удалено, вместо него добавлен `pageToken` с типом `string`.
1. Добавлено поле `ignoreSharedEntries` с типом `boolean`, которое позволяет исключать из ответа общие объекты.

## Версия 1 {#version-1}

### 22.01.2026 {#22012026}

22 января 2026 года запущено DataLens Public API версии 1.


_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._