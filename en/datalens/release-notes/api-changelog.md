---
title: Public API versioning in {{ datalens-full-name }}
description: Public API versioning in {{ datalens-full-name }} ensures compatibility of methods and object schemas between the API and the interface.
---
# {{ datalens-full-name }} Public API release notes

This section contains the {{ datalens-name }} Public API release notes. For more on versioning, see [this guide](../operations/api-versioning.md).


## Version 3 {#version-3}


### September 8, 2026: Upgrading to version 3 {#08092026}


1. Revised the argument/response schemas in methods for working with wizard charts:

   * [getWizardChart]({{ api-host-datalens }}/#/HtmlPages/post_rpc_getWizardChart)
   * [createWizardChart]({{ api-host-datalens }}/#/HtmlPages/post_rpc_createWizardChart)
   * [updateWizardChart]({{ api-host-datalens }}/#/HtmlPages/post_rpc_updateWizardChart)
   
1. Updated methods for working with dashboards and reports:

   * Added v2 versions of methods for getting, creating, and updating dashboards and reports:
     
     * [getDashboardV2]({{ api-host-datalens }}/#/HtmlPages/post_rpc_getDashboardV2)
     * [createDashboardV2]({{ api-host-datalens }}/#/HtmlPages/post_rpc_createDashboardV2)
     * [updateDashboardV2]({{ api-host-datalens }}/#/HtmlPages/post_rpc_updateDashboardV2)
     * [getPresentationV2]({{ api-host-datalens }}/#/HtmlPages/post_rpc_getPresentationV2)
     * [createPresentationV2]({{ api-host-datalens }}/#/HtmlPages/post_rpc_createPresentationV2)
     * [updatePresentationV2]({{ api-host-datalens }}/#/HtmlPages/post_rpc_updatePresentationV2)
     
   * Removed these fields from the schemas:
     
     * `schemeVersion`: Service version field for dashboards.
     * `data.version`: Service version field for reports.
     * `data.description`: Replaced with `annotation.description`.
     * `background`: Deprecated UI customization field.
     * `textColor`: Deprecated UI customization field.
     * `widgetTabId`: Deprecated field for dashboard insights.

   * For dataset selectors, `fieldType` now only accepts values from the dataset's data types, e.g., `string`, `integer`, `date`, and `genericdatetime`. For manual selectors, the `fieldType` field is preserved only for date selectors.
   * Added a requirement that dashboards must have at least one tab in `data.tabs`.

1. Migrations (when obtained via the [getDashboardV2]({{ api-host-datalens }}/#/HtmlPages/post_rpc_getDashboardV2) method or when saved in the v1 entity interface):

   * Migrated dashboard description from `data.description` to `annotation.description`.
   * Migrated background colors of all widgets from the deprecated `background` to `backgroundSettings.color: {light, dark}`, and the header text color, from `textColor` to `textSettings.color: {light, dark}`. The final color format is `HEX`.
   *  If there is no existing current `widgetTabIds` during migration, `widgetTabId` migrates as an array containing a single item (`widgetTabIds`).


## Version 2 {#version-2}



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

