---
title: '{{ datalens-full-name }} release notes: February 2025'
description: Check out {{ datalens-full-name }} release notes for February 2025.
---

# {{ datalens-full-name }} release notes: February 2025


* [Changes in basic features](#base)
* [Changes available with the _Business_ service plan](#business)

## Changes in basic features {#base}



### Setting the markup type {#markup-type}

In [charts](../concepts/chart/dataset-based-charts.md), you can no longer select the markup type in the dataset [field settings](../concepts/chart/settings.md#measure-settings). This option is now only available in the visualization sections.

### Fixes in charts {#charts-fixes}

* Fixed incorrect rendering of the gradient [fill](../concepts/chart/settings.md#color-settings) legend for charts with negative values.
* Fixed a bug in tables where zero-value [linear indicators](../visualization-ref/table-chart.md#add-linear-indicator) persisted after filtering out.
* Fixed an issue in [combined charts](../visualization-ref/combined-chart.md) that prevented adding a measure to the **Color** section.
* Fixed axis renaming in [QL charts](../concepts/chart/ql-charts.md) within the [section settings](../concepts/chart/settings.md#section-settings) to match the behavior of [dataset-based charts](../concepts/chart/index.md).
* Fixed an issue in charts where duplicating a [measure](../concepts/chart/settings.md#indicator-settings) caused the new field type to reset to the original field computed type, ignoring its settings. For example, changing the original field type from `Float ` to `Integer` would reset the duplicated field to `Float`. Now, the new field retains the correct type based on the original field settings.

### Dashboard fixes {#dashboard-fixes}

* Removed the link to guides on [filtering charts by charts](../dashboard/chart-chart-filtration.md#using) from the [dashboard chart](../operations/dashboard/add-chart.md) settings. It now appears when you hover over ![image](../../_assets/console-icons/circle-question.svg).
* Pinned the table of contents on the [dashboard](../concepts/dashboard.md) so it no longer moves when scrolling.
* Fixed an issue preventing users from [getting the embed code](../security/embedded-objects.md#get-code) for a public dashboard.

### New features for Markdown markup and editors {#new-features}

Added new features to [Markdown](../dashboard/markdown.md) markup and editors:

* [Text formatting](../dashboard/markdown.md#emphasizing) options, such as underline, strikethrough, lowercase, monospace, and highlighted text.
* [Tabs](../dashboard/markdown.md#tabs).
* [Mermaid diagrams](../dashboard/markdown.md#mermaid).
* [Emoji](../dashboard/markdown.md#emoji).

### Aggregation type for bulk dataset operations {#bulk-changes-aggregations}

Fixed an issue with changing the aggregation type in bulk [dataset](../dataset/index.md) operations. Earlier, when filtering the list of fields and selecting all fields at the top left, the list for changing the aggregation type displayed incorrectly.



### Creating a support ticket {#support-message}

When opening a `Question` or `Issue` ticket, the system will now generate a suggested solution via the {{ search-api-full-name }} based on the subject you enter.

## Changes available with the _Business_ service plan {#business}

### Changes in reports {#reports-changes}

* You can now move [report widgets](../reports/report-operations.md#add-widget) using the following hotkeys and shortcuts:

  * Arrow keys to move by one pixel.
  * **Shift** + arrow keys to move by ten pixels.

* Selector group name is now displayed by default.

* The [report widget settings](../reports/report-operations.md#add-widget) now allow specifying a custom background color using a hex code, such as `#82AFD3`.

* Fixed an issue with [report creation](../reports/report-operations.md#create-report) from the navigation bar with [folder navigation disabled](../settings/disable-folder-navigation.md). Now, when creating a report, a dialog box appears prompting you to select a workbook.

