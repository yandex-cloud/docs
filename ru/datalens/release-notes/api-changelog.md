---
title: Версионирование Public API в {{ datalens-full-name }}
description: Версионирование Public API в {{ datalens-full-name }} поддерживает совместимость методов и схем объектов в API с методами и схемами объектов в интерфейсе.
---
# История изменений Public API в {{ datalens-full-name }}

В этом разделе собрана история изменений {{ datalens-name }} Public API. Подробнее про версионирование в [документации](../operations/api-versioning.md).


## Версия 3 {#version-3}


### 08.09.2026 — переход на версию 3 {#08092026}


1. Изменили схему аргументов/ответа методов для работы с чартами в визарде:

   * [getWizardChart]({{ api-host-datalens }}/#/HtmlPages/post_rpc_getWizardChart)
   * [createWizardChart]({{ api-host-datalens }}/#/HtmlPages/post_rpc_createWizardChart)
   * [updateWizardChart]({{ api-host-datalens }}/#/HtmlPages/post_rpc_updateWizardChart)
   
1. Изменили методы для работы с дашбордами и отчетами:

   * Добавили v2-версии методов получения, создания и обновления дашбордов и отчетов:
     
     * [getDashboardV2]({{ api-host-datalens }}/#/HtmlPages/post_rpc_getDashboardV2)
     * [createDashboardV2]({{ api-host-datalens }}/#/HtmlPages/post_rpc_createDashboardV2)
     * [updateDashboardV2]({{ api-host-datalens }}/#/HtmlPages/post_rpc_updateDashboardV2)
     * [getPresentationV2]({{ api-host-datalens }}/#/HtmlPages/post_rpc_getPresentationV2)
     * [createPresentationV2]({{ api-host-datalens }}/#/HtmlPages/post_rpc_createPresentationV2)
     * [updatePresentationV2]({{ api-host-datalens }}/#/HtmlPages/post_rpc_updatePresentationV2)
     
   * Из схем удалили поля:
     
     * `schemeVersion` — служебное поле версии у дашбордов;
     * `data.version` — служебное поле версии у отчетов;
     * `data.description` — вместо этого поля теперь используется `annotation.description`;
     * `background` — устаревшее поле оформления;
     * `textColor` — устаревшее поле оформления;
     * `widgetTabId` — устаревшее поле инсайта на дашборде.

   * Для dataset-селекторов `fieldType` теперь принимает только значения из перечисления типов данных датасета, например `string`, `integer`, `date` и `genericdatetime`. Для manual-селекторов поле `fieldType` сохраняется только у селекторов даты.
   * Добавили условие, при котором у дашбордов обязателен хотя бы один таб в `data.tabs`.

1. Миграции (при получении через метод [getDashboardV2]({{ api-host-datalens }}/#/HtmlPages/post_rpc_getDashboardV2) или при сохранении в интерфейсе сущности v1):

   * Описание дашборда переносится из `data.description` в `annotation.description`.
   * Цвета фона всех виджетов переносятся из устаревшего `background` в `backgroundSettings.color: {light, dark}`, а цвет текста заголовка — из `textColor` в `textSettings.color: {light, dark}`. Конечный формат цвета — `HEX`.
   *  При отсутствии существующего актуального `widgetTabIds` при миграции `widgetTabId` перенесется в формате массива с одним элементом `widgetTabIds`.


## Версия 2 {#version-2}



### 28.07.2026 {#28072026}

Совместимые изменения в Public API версии 2.

1. Добавились методы для работы с HTML-страницами:

   * [createHtmlPage]({{ api-host-datalens }}/#/HtmlPages/post_rpc_createHtmlPage)
   * [deleteHtmlPage]({{ api-host-datalens }}/#/HtmlPages/post_rpc_deleteHtmlPage)
   * [getHtmlPage]({{ api-host-datalens }}/#/HtmlPages/post_rpc_getHtmlPage)
   * [updateHtmlPage]({{ api-host-datalens }}/#/HtmlPages/post_rpc_updateHtmlPage)

1. Добавили методы для управления блокировками редактирования сущностей {{ datalens-name }} (например, чартов, дашбордов и т. д.):

   * [createEntryLock]({{ api-host-datalens }}/#/EntryLock/post_rpc_createEntryLock)
   * [deleteEntryLock]({{ api-host-datalens }}/#/EntryLock/post_rpc_deleteEntryLock)
   * [extendEntryLock]({{ api-host-datalens }}/#/EntryLock/post_rpc_extendEntryLock)

1. Убрали тег `[Experimental]` с методов для работы с дашбордами:

   * [createDashboard]({{ api-host-datalens }}/#/Dashboard/post_rpc_createDashboard)
   * [deleteDashboard]({{ api-host-datalens }}/#/Dashboard/post_rpc_deleteDashboard)
   * [getDashboard]({{ api-host-datalens }}/#/Dashboard/post_rpc_getDashboard)
   * [updateDashboard]({{ api-host-datalens }}/#/Dashboard/post_rpc_updateDashboard)


### 15.06.2026 {#15062026}

Совместимые изменения в Public API версии 2. Добавились методы:

* [batchListMembers]({{ api-host-datalens }}/#/Access/post_rpc_batchListMembers)
* [deleteFolder]({{ api-host-datalens }}/#/Folder/post_rpc_deleteFolder)
* [dlsSuggest]({{ api-host-datalens }}/#/Folder/post_rpc_dlsSuggest)
* [getPermissions]({{ api-host-datalens }}/#/Folder/post_rpc_getPermissions)
* [modifyPermissions]({{ api-host-datalens }}/#/Folder/post_rpc_modifyPermissions)
* [moveFolderEntry]({{ api-host-datalens }}/#/Folder/post_rpc_moveFolderEntry)

### 11.06.2026 — переход на версию 2 {#11062026}

Несовместимые изменения с Public API версии 1. Изменилась версия Public API: теперь актуально Public API версии 2.

Несовместимое изменение затронуло метод `getEntries`, с помощью которого можно получать сущности {{ datalens-full-name }}.

1. Для поля `ids` изменился тип данных: `string | string[]` → `string[]`.
1. Для поля `createdBy` изменился тип данных: `string | string[]` → `string[]`.
1. Поле `page` с типом `number` удалено, вместо него добавлен `pageToken` с типом `string`.
1. Добавлено поле `ignoreSharedEntries` с типом `boolean`, которое позволяет исключать из ответа общие объекты.

## Версия 1 {#version-1}

### 22.01.2026 {#22012026}

22 января 2026 года запущено {{ datalens-name }} Public API версии 1.

