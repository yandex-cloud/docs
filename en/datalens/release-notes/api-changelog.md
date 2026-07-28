---
title: Public API versioning in {{ datalens-full-name }}
description: Public API versioning in {{ datalens-full-name }} ensures compatibility of methods and object schemas between the API and the interface.
---
# {{ datalens-full-name }} Public API release notes

This section contains the {{ datalens-name }} Public API release notes. For more on versioning, see [this guide](../operations/api-versioning.md).

## Version 2{#version-2}

### 15.06.2026 {#15062026}

Non-breaking changes in the Public API version 2. Added the following methods:


* [batchListMembers](https://api.datalens.tech/#/Access/post_rpc_batchListMembers)
* [deleteFolder](https://api.datalens.tech/#/Folder/post_rpc_deleteFolder)
* [dlsSuggest](https://api.datalens.tech/#/Folder/post_rpc_dlsSuggest)
* [getPermissions](https://api.datalens.tech/#/Folder/post_rpc_getPermissions)
* [modifyPermissions](https://api.datalens.tech/#/Folder/post_rpc_modifyPermissions)
* [moveFolderEntry](https://api.datalens.tech/#/Folder/post_rpc_moveFolderEntry)


### June 11, 2026: Upgrading to version 2 {#11062026}

Breaking changes to the Public API version 1. A new Public API major version is out: Public API version 2.

Introduced breaking changes to the `getEntries` method for retrieving {{ datalens-full-name }} entities.

1. Changed the `ids` field data type: `string | string[]` → `string[]`.
1. Changed the `createdBy` field data type: `string | string[]` → `string[]`.
1. Removed the `page` field of the `number` type, replacing it with `pageToken` of the `string` type.
1. Added a new `ignoreSharedEntries` field of the `boolean` type to remove shared objects from the response.

## Version 1 {#version-1}

### 22.01.2026 {#22012026}

January 22, 2026: the {{ datalens-name }} Public API version 1 is out.