---
title: Версионирование Public API в {{ datalens-full-name }}
description: Версионирование Public API в {{ datalens-full-name }} поддерживает совместимость методов и схем объектов в API с методами и схемами объектов в интерфейсе.
---
# История изменений Public API в {{ datalens-full-name }}

В этом разделе собрана история изменений {{ datalens-name }} Public API. Подробнее про версионирование в [документации](../operations/api-versioning.md).

## Версия 2 {#version-2}

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

Несовместимое изменение затронуло метод `getEntries`, с помощью которого можно получать сущности {{ datalens-full-name }}.

1. Для поля `ids` изменился тип данных: `string | string[]` → `string[]`.
1. Для поля `createdBy` изменился тип данных: `string | string[]` → `string[]`.
1. Поле `page` с типом `number` удалено, вместо него добавлен `pageToken` с типом `string`.
1. Добавлено поле `ignoreSharedEntries` с типом `boolean`, которое позволяет исключать из ответа общие объекты.

## Версия 1 {#version-1}

### 22.01.2026 {#22012026}

22 января 2026 года запущено {{ datalens-name }} Public API версии 1.