---
title: Public API versioning in {{ datalens-full-name }}
description: Public API versioning in {{ datalens-full-name }} ensures compatibility of methods and object schemas between the API and the interface.
---
# {{ datalens-full-name }} Public API release notes

This section contains the {{ datalens-name }} Public API release notes. For more on versioning, see [this guide](../operations/api-versioning.md).

## Version 2{#version-2}

### 28.07.2026 {#28072026}

Non-breaking changes in the Public API version 2.

1. Added methods for working with HTML pages:

   * [createHtmlPage]({{ api-host-datalens }}/#/HtmlPages/post_rpc_createHtmlPage)
   * [deleteHtmlPage]({{ api-host-datalens }}/#/HtmlPages/post_rpc_deleteHtmlPage)
   * [getHtmlPage]({{ api-host-datalens }}/#/HtmlPages/post_rpc_getHtmlPage)
   * [updateHtmlPage]({{ api-host-datalens }}/#/HtmlPages/post_rpc_updateHtmlPage)

1. Added methods for managing edit locks on {{ datalens-name }} entities, e.g., charts, dashboards, etc.:

   * [createEntryLock]({{ api-host-datalens }}/#/EntryLock/post_rpc_createEntryLock)
   * [deleteEntryLock]({{ api-host-datalens }}/#/EntryLock/post_rpc_deleteEntryLock)
   * [extendEntryLock]({{ api-host-datalens }}/#/EntryLock/post_rpc_extendEntryLock)

1. Removed the `[Experimental]` tag from dashboard management methods:

   * [createDashboard]({{ api-host-datalens }}/#/Dashboard/post_rpc_createDashboard)
   * [deleteDashboard]({{ api-host-datalens }}/#/Dashboard/post_rpc_deleteDashboard)
   * [getDashboard]({{ api-host-datalens }}/#/Dashboard/post_rpc_getDashboard)
   * [updateDashboard]({{ api-host-datalens }}/#/Dashboard/post_rpc_updateDashboard)


### 15.06.2026 {#15062026}

Non-breaking changes in the Public API version 2. Added the following methods:

* [batchListMembers]({{ api-host-datalens }}/#/Access/post_rpc_batchListMembers)
* [deleteFolder]({{ api-host-datalens }}/#/Folder/post_rpc_deleteFolder)
* [dlsSuggest]({{ api-host-datalens }}/#/Folder/post_rpc_dlsSuggest)
* [getPermissions]({{ api-host-datalens }}/#/Folder/post_rpc_getPermissions)
* [modifyPermissions]({{ api-host-datalens }}/#/Folder/post_rpc_modifyPermissions)
* [moveFolderEntry]({{ api-host-datalens }}/#/Folder/post_rpc_moveFolderEntry)

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
