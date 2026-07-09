[Документация Yandex Cloud](../../index.md) > [Yandex DataLens](../index.md) > DataLens Public API > История изменений

# История изменений Public API в Yandex DataLens

В этом разделе собрана история изменений DataLens Public API. Подробнее про версионирование в [документации](../operations/api-versioning.md).

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

Несовместимое изменение затронуло метод `getEntries`, с помощью которого можно получать сущности Yandex DataLens.

1. Для поля `ids` изменился тип данных: `string | string[]` → `string[]`.
1. Для поля `createdBy` изменился тип данных: `string | string[]` → `string[]`.
1. Поле `page` с типом `number` удалено, вместо него добавлен `pageToken` с типом `string`.
1. Добавлено поле `ignoreSharedEntries` с типом `boolean`, которое позволяет исключать из ответа общие объекты.

## Версия 1 {#version-1}

### 22.01.2026 {#22012026}

22 января 2026 года запущено DataLens Public API версии 1.