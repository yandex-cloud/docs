---
title: '{{ datalens-full-name }} release notes: June 2026'
description: Check out {{ datalens-full-name }} release notes for June 2026.
---

# {{ datalens-full-name }} release notes: June 2026

* [Changes in basic features](#base)
* [Fixes and improvements](#fixes)

## Changes in basic features {#base}


* Implemented [agent mode](../dashboard/insights.md#neuroanalyst-2) for Neuroanalyst on the dashboard. In this mode, Neuroanalyst analyzes the dataset your dashboard is based on and can respond by selecting a chart or building a new one based on the dataset. For context, it uses the dataset and a [reference tab](../dashboard/insights.md#reference-tab). When in agent mode, Neuroanalyst uses charts from the reference tab as templates for new charts.

  You can [enable Neuroanalyst's agent mode](../dashboard/insights.md#turn-on) in its settings on the dashboard:
  
  1. If the **Neuroanalyst** option is off, turn it on (on by default).
  1. Enable the **Agent mode** option.
  1. [Select a reference tab](../operations/dashboard/dashboard-ai-reference-tab.md) if your dashboard has more than one tab.
  1. Optionally, [hide](../operations/dashboard/dashboard-hide-tabs.md) the reference tab in the dashboard settings.

  When selecting a reference tab, please follow these recommendations:

  * On the tab, place [wizard charts](../concepts/chart/dataset-based-charts.md) that describe your dataset in various aspects and answer different questions.
  * In the descriptions of your dashboard charts or widgets, provide examples of questions they help answer.
  * Instead of tab selectors, use filters in charts to make your charts answer more specific questions.
  * Use charts built on a single dataset.
  * Use relevant field descriptions in the dataset.

  Current limitations:

  * Works only on one dataset, the one your reference tab is based on.
  * The titles of the first three charts get into Neuroanalyst's recommendations.

  Try out Neuroanalyst's agent mode on the public [demo dashboard](https://datalens.yandex/9fms9uae7ip02) (click ![image](../../_assets/console-icons/sparkles.svg) in the bottom-right corner).
  Also see the [reference tab](https://datalens.yandex/9fms9uae7ip02?tab=et01) example.

* Implemented the ability to add Neuroanalyst to the [dashboard](../operations/dashboard/add-ai.md) and [report](../reports/insights.md) as a separate [Insight](../dashboard/widget.md#ai) widget.
  
  This widget displays Neuroanalyst's insights for the selected chart on the current dashboard tab or report page. When adding a widget, you can set a custom prompt asking about the data. When you save a dashboard or report, the system will analyze the chart you specify and return its findings based on the chart and custom prompt data. The result will be updated every time you open the dashboard or report.

* Updated dashboard [mailing lists](../operations/dashboard/add-maillists.md):

  * Now, within a single mailing list, you can set up multiple states with sets of attached screenshots in the email, e.g., for each of the tabs.
  * Added the screenshot auto height setting.
  * Added the ability to specify the date in the attached file's name.
  * Implemented the ability to select several users in a separate window.


* Added new dashboard style options:
  
  * Dashboard [background](../operations/dashboard/add-dashboard-background.md) separately for light and dark themes.
  * [Background and transparency](../operations/dashboard/add-widget-background.md) separately for light and dark themes for all dashboard widgets.
  * Rounding for all [dashboard](../operations/dashboard/add-rounding.md) and [report](../reports/report-operations.md#widget-rounding) widgets separately for light and dark themes.

* Added the ability to save a [draft version](../dataset/versioning.md#version-types) of the dataset.
  
  A draft is a version containing unsaved dataset changes. Common users see none of the changes made to the draft. The charts and dashboards based on it remain unchanged. This allows you to hide dataset edits until you actualize your version.
  
  To create a draft after you have edited a dataset, click the check mark in the top-right corner and select **Save as draft**.

  To apply changes to visualizations, in draft view mode, click **Make actual**.


## Fixes and improvements {#fixes}


* Added the ability to upload files when [importing a workbook](../workbooks-collections/export-and-import.md#import-workbook) via drag and drop.
* Added the ability to select a range of objects in the list of workbooks and collections: hold down the **Shift** key and mark the beginning and end of the range with your mouse.
* Updated the embed and public access settings dialog. To access the settings, click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/arrow-shape-turn-up-right.svg) **Share** at the top of the chart or dashboard and select a tab:

  * **In organization**: To set up [access to a workbook](../security/workbooks-access.md) or [share a link within an organization](../concepts/datalens-sharing.md).
  * **Publicly**: To set up [public access](../concepts/datalens-public.md) via a link for external users.
  * **Embed**: To [embed private objects](../security/private-embedded-objects.md).

* Fixed the context menu for shared objects in the navigation bar.
* Improved access permission management: now the `Editor` [role](../security/roles.md#datalens-workbooks-editor) is enough to delete datasets and connections in a workbook.
* Fixed a bug where breadcrumbs were not automatically updated when copying a workbook from a nested collection.


* Provided the ability to change the chart and dashboard background color using special parameters in the link:


  * `_bg_color`: Sets the background color of:
    
    * [Private](../security/private-embedded-objects.md) charts and dashboards in hexadecimal format, e.g., `_bg_color=D7F7F7`.
    * [Public](../concepts/datalens-public.md) charts and dashboards in hexadecimal format, only if `_embedded` equals `1`, e.g., `_bg_color=D7F7F7&_embedded=1`.

  * `_widgets_bg_color`: Sets the background color of:
    
    * Private dashboard widgets in hexadecimal format, e.g., `_widgets_bg_color=B7F7F7`.
    * Public dashboard widgets in hexadecimal format, only if `_embedded` equals `1`, e.g., `_widgets_bg_color=B7F7F7&_embedded=1`.


### Fixes in connections {#connection-fixes}

* Fixed an OAuth token [connection](../concepts/connection/index.md) authorization issue in the Safari browser.


### Fixes in datasets {#dataset-fixes}

* Fixed an error that occurred when replacing a connection with a [shared](../security/workbooks-access-advanced.md) connection in a dataset.


### Fixes in reports {#report-fixes}

* Fixed errors in report [preview](../reports/report-operations.md#report-preview) modes in document and presentation formats where the content could not be scaled up to full screen.


### Dashboard fixes {#dashboard-fixes}

* Changed [inserting a copied selector](../operations/dashboard/add-selector.md#copy-paste) with display settings on `Selected tabs`. Now, if you select the following in the insert dialog box:

  * **Copy**: Creates an independent selector on the current tab.
  * `Update settings`: After the insertion, the original selector's **Show in tabs** setting will be automatically updated.
  * If you close the window, the selector will not be inserted.

* The [mobile widget order](../operations/dashboard/display-modes.md) menu now gives access to global selectors.
* You can now reset the appearance of the dashboard itself or the dashboard and all charts on it. Do it in dashboard editing mode by clicking ![image](../../_assets/console-icons/arrow-rotate-left.svg) to the right of the **Appearance** section's name and select `Reset dashboard appearance` or `Reset the appearance of dashboard and all charts`.
* Added a restriction for widgets featuring a group of selectors: you can no longer save a group in which several selectors refer to the same parameter. Previously, this restriction applied only to manual selectors; now it also applies to dataset selectors.
* Added a missing parameter message when opening the dashboard settings window.
* Now you can add questions for the Neuroanalyst chat in the dashboard settings in Neuroanalyst's agent mode. By default, questions are taken from descriptions and titles of the first three widgets on the reference tab. To ask your own questions, go to the dashboard settings:
  
  1. If the **Neuroanalyst** option is off, turn it on (on by default).
  1. Enable the **Agent mode** option.
  1. [[Select a reference tab](../operations/dashboard/dashboard-ai-reference-tab.md)](../operations/dashboard/dashboard-ai-reference-tab.md) if your dashboard has more than one tab.
  1. Opposite to **Example questions**, click ![image](../../_assets/console-icons/pencil.svg) and, in the window that opens, enter your questions to Neuroanalyst. These questions will be displayed when you launch Neuroanalyst.
  1. Optionally, [hide](../operations/dashboard/dashboard-hide-tabs.md) the reference tab in the dashboard settings.


* Fixed a bug with global [selectors](../dashboard/selector.md) on the mobile dashboard.
* Fixed a `Calendar` selector bug where, after you selected a period, the calendar would reopen when hovering over the chart.
* Fixed a dashboard chart issue where the [calculated field](../concepts/calculations/index.md) tooltip value would not update if using fields dependent on dashboard filters.
* Fixed a bug in selectors with shared datasets.


### Fixes in charts {#chart-fixes}

* Fixed the following for the [combined chart](../visualization-ref/combined-chart.md):
 
  * Incorrect display of charts with a category axis with sorting on.
  * Caption overlay.

* Fixed the following for the [normalized column chart](../visualization-ref/combined-chart.md):
  
  * Error when selecting `HTML` in the **Markup** setting for a field in the **Split** section.
  * Chart display with the **Split** section.

* Fixed the display of captions in a [column chart](../visualization-ref/column-chart.md) with sorting.
* In the chart inspector, added splitting several queries with `;` to run two queries at once.
* In the wizard, restored the ![image](../../_assets/console-icons/ellipsis.svg) button when hovering over a dataset to be able to open and use the menu.
* Fixed incorrect filter operation when using an empty field.
* In charts with hierarchy, fixed the selection of the X-axis display mode when editing.


* Fixed a scrolling problem in the widget chart list in Safari triggered by large numbers of charts.

### Changes in Editor {#editor-fixes}

* Fixed re-rendering of the [Advanced chart](../charts/editor/widgets/advanced.md) when resizing the parent widget.
* Fixed the **Create Editor chart** button in the [API Connector](../operations/connection/create-api-connector.md) connection, which now correctly redirects to Editor's visualization selection page.

