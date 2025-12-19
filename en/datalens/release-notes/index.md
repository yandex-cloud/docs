---
title: '{{ datalens-full-name }} release notes: November 2025'
description: Check out {{ datalens-full-name }} release notes for November 2025.
---

# {{ datalens-full-name }} release notes: November 2025

* [Changes in basic features](#base)
* [Fixes and improvements](#fixes)

## Changes in basic features {#base}


* Starting December 1, {{ datalens-full-name }} introduces a revised pricing policy. Under the new unified service plan, all users will gain access to expanded capabilities, including [Neuroanalyst](../concepts/neuroanalyst.md), [reports](../reports/index.md), JavaScript-based customizations in [Editor](../charts/editor/index.md), [background chart data export](../concepts/chart/data-export.md#background-export), [UI styling](../settings/appearance.md#ui-customization), and more. The new plan will be offered free of charge for individual use and for a fee for team work.

  For more information, see the [pricing policy updates](../pricing-changes.md).

* Added a new section with info about the annual [{{ datalens-short-name }} festival]({{ link-datalens-main }}/festival).
* In connections to [{{ TR }}](../operations/connection/create-trino.md), [{{ PG }}](../operations/connection/create-postgresql.md), and [{{ GP }}](../operations/connection/create-greenplum.md), reduced workload on the source when selecting tables. What's new:

  * Table lists are filtered and paginated on the database side.
  * For [{{ TR }}](../operations/connection/create-trino.md#create-dataset), when you create a dataset, the table search is limited to the selected catalog.

* The chat with the [report Neuroanalyst](../reports/insights.md) does not close when you switch between the pages of the report.



* Updated the appearance of [chart](../dashboard/widget.md#chart) widget settings.

## Fixes and improvements {#fixes}


* Fixed an issue where the [{{ datalens-gallery }}](https://datalens.ru/gallery) section did not appear if no organization was selected on the {{ datalens-short-name }} [main page]({{ link-datalens-main }}/init).
* Added an update to the widget menu in reports after loading data.
* Fixed chart loading when scrolling the dashboard. Previously, empty widgets would appear from time to time.
* Fixed a private object embedding issue where [signed parameters](../security/private-embedded-objects.md#signed-parameters) did not affect dataset-based selectors.


* In the [dataset field settings](../dataset/create-dataset.md#setup-fields), fixed a bug that made it impossible to assign the same color to different fields.
* In reports, fixed an issue with pivot table presentation after changing the [page format](../reports/report-operations.md#page-settings).

### Fixes in charts {#chart-fixes}

* Fixed the display of [tables](../visualization-ref/table-chart.md) with empty (`null`) values in `Markup` type fields (fields using the [markup functions](../function-ref/markup-functions.md)).
* Fixed the chart title font color setting in [Gravity UI Charts](../charts/editor/widgets/chart.md).


### Fixes in Neuroanalyst {#neuroanalyst-fixes}

* On dashboards, the [Neuroanalyst](../concepts/neuroanalyst.md) chat box can now appear not only on top of the dashboard but also along its side, thus compressing it sideways (default). To change the chat position, click:
  
  * ![image](../../_assets/console-icons/pin-slash.svg): Chat on the top of the dashboard.
  * ![image](../../_assets/console-icons/pin.svg): Chat along the side of the dashboard.

* The Neuroanalyst chat now closes as soon as you switch to dashboard edit mode.
* When in dashboard edit or create mode, the Neuroanalyst chat opening button is now hidden.
* Closing the Neuroanalyst chat does not delete its contents. When you open the chat for the same widget or dashboard, you will see your previous dialog. Opening the chat for a new widget will start a new dialog.
* Fixed Neuroanalyst chat positioning when minimized.
* Fixed the Neuroanalyst chat bugs, where:

  * Queries related to the Neuroanalyst chat were still executed after you closed it.
  * The Neuroanalyst chat was displayed even if you tried to hide it.
  * Neuroanalyst froze or displayed a white screen in the chat box after you clicked **Start again**.
  * The buttons for hiding ![image](../../_assets/console-icons/chevrons-up.svg) and showing ![image](../../_assets/console-icons/chevrons-down.svg) the [pinned widgets](../dashboard/settings.md#widget-fixation) area were displayed on top of the open Neuroanalyst chat.

### Mobile version updates {#mobile-version-changes}

* Chart [legends](../concepts/chart/settings.md#common-settings) in full screen mode are no longer concealed behind the browser panel if using a non-standard address bar layout (e.g., mobile Yandex Browser with the bottom panel).

