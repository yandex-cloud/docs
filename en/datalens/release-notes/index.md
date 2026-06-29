---
title: '{{ datalens-full-name }} release notes: May 2026'
description: Check out {{ datalens-full-name }} release notes for May 2026.
---

# {{ datalens-full-name }} release notes: May 2026

* [Changes in basic features](#base)
* [Fixes and improvements](#fixes)

## Changes in basic features {#base}


* New dashboards available in [{{ datalens-gallery }}]({{ link-datalens-main }}/gallery). For more information, see the [{{ datalens-short-name }}](https://messenger.360.yandex.ru/#/join/01a309da-b9a8-4167-9892-b72f1ec1bff0/1778684386173061) chat in {{ messenger-full-name }}.
* We have prepared for you a brief video digest covering {{ datalens-full-name }} updates over the past two quarters. Watch on your preferred platform:

  * [YouTube](https://youtu.be/NphWrA3TFWs)
  * [VK Video](https://vkvideo.ru/video-200452713_456240432?list=ln-yghSH3nJwSMTzT5WVh)
  * [RuTube](https://rutube.ru/video/7af10c515697b698319c7f2b76b6fc3e/)

* Implemented the [{{ SR }}](../operations/connection/create-starrocks.md) connector that enables creating a connection using a direct link.

* Added a new form for creating a [dashboard mailing list](../dashboard/settings.md#maillists).
  
  You can now configure scheduled mailings of dashboard snapshots to email addresses of {{ datalens-short-name }} users.
  
  When creating a mailing list, consider the following:
  
  * Mailing lists are only available for dashboards stored in [workbooks](../workbooks-collections/index.md).
  * A user with the `{{ roles-datalens-admin }}` role can add or update a mailing list.
  * You can customize the dashboard state for each mailing list, e.g., select specific tabs and selector values.

  {% cut "Mailing list email content" %}

  ![maillist-content](../../_assets/datalens/release-notes/maillist-content.png)

  {% endcut %}

* Revised the dialog for assigning access permissions. For each user or group, the permissions settings window displays the effective role for the current object (collection or workbook).
  
  Optionally, you can open a window with an individual user’s permissions settings to view details, including roles inherited from parent collections.

* Added new [roles for collections](../security/workbooks-access-basic.md#collection-roles):

  * The `Collection visitor` role allows you to view information about the collection without access to its nested objects.
  * The `Creator in collection` role allows you to view a collection and create objects inside it without accessing the existing ones.
  
  Previously, when a user had access to a workbook but not to its parent collections, they could only access the workbook via a direct link or through lists of available objects. Now you can grant permissions to visit specific collections, and create objects inside them without access to existing objects.

* Implemented access management using [shared objects](../security/workbooks-access-advanced.md). Shared objects are connections and datasets you can reuse and link to multiple workbooks across different teams.
  
  When linking a shared object, select a permission delegation option:
  
  * **Delegate access permissions**: Access permissions to the shared object (connection or dataset) will not be checked within the workbook. This means that anyone with access to the workbook the connection is linked to will also have access to the object.
  * **Do not delegate access permissions**: For users to access the object (connection or dataset) from the workbook, they must be granted access to the original, i.e., the shared object.

  Linking an object to a workbook requires appropriate permissions for the shared objects, so we added two additional roles:

  * The `Links without delegation` role for a shared object allows you to link it to workbooks without delegating access permissions.
  * The `Links with delegation` role for a shared object allows you to link it to workbooks with or without delegating access permissions.


* Implemented early [cache invalidation](../dataset/cache-invalidation.md) in datasets:

  * Cache invalidation allows you to reduce the number of queries to the source and optimize cache usage in {{ datalens-short-name }}.
  * Cache invalidation conditions are defined in dataset settings.
  * Available [invalidation modes](../dataset/cache-invalidation.md#modes): SQL-based and formula-based.

  {{ datalens-short-name }} caches query results from data sources to accelerate chart and dashboard rendering. By default, the cache refreshes only after its TTL expires. This may become a constraint if you need real-time visibility, as your data will update regularly but infrequently.
  
  Here is how cache invalidation solves this issue: the system runs an occasional _invalidation query_ against the data source to check if the data has changed. If the query returns a different result, the cache refreshes immediately without waiting for TTL expiration.

* Redesigned the color picker tool, introducing an enhanced color palette and improved visual display. This redesign applies to report [widget background settings](../reports/report-operations.md#widget-background), [chart color settings](../concepts/chart/settings.md#color-settings), [dataset field color settings](../dataset/create-dataset.md#setup-fields), and global [appearance](../settings/appearance.md) settings.

* Implemented hiding dashboard tabs. You can [choose to display](../operations/dashboard/dashboard-hide-tabs.md) all or selected tabs. Hidden tabs are not visible by default when you open the dashboard, but you see them if you use a link to a hidden tab to open the dashboard. Hidden tabs are visible in edit mode.

  Use cases for hidden tabs include:

  * Hiding archived tabs prior to deletion.
  * Staging new tabs that are still in development before making them visible to all users.
  * Adding a tab with details that is only accessible by clicking a link in another chart.


## Fixes and improvements {#fixes}



* Now you can search licenses by `userId`.


* Fixed a [background export](../concepts/chart/data-export.md#background-export) error in cells containing special characters.

### Fixes in connections {#connection-fixes}

* Fixed an issue where connections to [Google Sheets](../operations/connection/create-google-sheets.md) could persist despite an outdated state.

### Fixes in reports {#chart-fixes}

* Fixed [report export](../reports/report-operations.md#report-export) issues, including:
  
  * Incorrect display of the note icon in text widgets.
  * Images loading failures in Safari.
  * Incorrect text wrapping in the **Header** widget when widget size was insufficient to accommodate the full text.
  
* Report pages in the preview area in Safari now load faster.


### Dashboard fixes {#dashboard-fixes}

* Restricted the scope of selectors displayed on multiple tabs. Previously, default values of such selectors could also affect tabs where those selectors were not visible.
* Fixed a group selector copying error.

  Previously, pasting a group selector with a group-wide setting caused the tab to malfunction if each individual selector was set to `Current tab`.

  Now, if you paste a selector with a group-wide setting into another tab and select **Edit settings**, the new settings will apply both to the group and each of its selectors (provided they are visible on the original tab).


### Fixes in charts {#chart-fixes}



* Added support for additional [trend and smoothing lines](../dashboard/trends-and-smoothing.md) on public dashboard charts.


* Fixed a hierarchical navigation error in [bar charts](../visualization-ref/bar-chart.md).
* Fixed the display of trailing zeros in [normalized column chart](../visualization-ref/normalized-column-chart.md) tooltips.

