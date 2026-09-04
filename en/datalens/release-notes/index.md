---
title: "{{ datalens-full-name }} release notes: July\_2026"
description: "Check out the {{ datalens-full-name }} release notes for July\_2026."
---

# {{ datalens-full-name }} release notes: July 2026

* [Changes in basic features](#base)
* [Fixes and improvements](#fixes)

## Changes in basic features {#base}

* Added a new section: [HTML pages]({{ link-datalens-main }}/pages). The feature allows {{ datalens-name }} users to [upload an HTML page](../html-pages/index.md) to a workbook or directory and share it with other users based on [access](../security/index.md) permissions.
  
  When preparing your HTML pages, use the [GitHub](https://github.com/datalens-tech/datalens-skills) skill that brings together the limitations and generation instructions.


* [Versioning for datasets](../dataset/versioning.md) now supports creating a draft version. Common users see none of the changes made to the draft. This allows you to hide dataset edits until you actualize your version.
* Added a new visualization type: [funnel](../visualization-ref/funnel.md). A funnel chart visualizes the successive reduction of measure values across the stages. Each stage of the funnel is represented by a segment whose width is proportional to the measure value.

  This visualization type is well-suited for analysis of processes where data goes through several successive stages. For example, in sales funnel analysis – from browsing to buying – or user conversion analysis through different stages of registration.

  {% cut "Example" %}

  ![funnel-chart](../../_assets/datalens/visualization-ref/funnel-chart/funnel-chart.png =800x)

  {% endcut %}

  Aspects of use:

  * You can specify funnel stages using either a dimension or a set of metrics.
  * Percentages in captions and tooltips can be calculated either from the initial stage or the previous stage.
  * Captions can feature several [measure values](../concepts/chart/measure-values.md) of different formats to show both absolute values and percentages.


* Added alignment settings for [tables](../visualization-ref/table-chart.md#additional-settings) and [pivot tables](../visualization-ref/pivot-table-chart.md#set-column-align).

## Fixes and improvements {#fixes}

* Implemented saving of user settings for the Neuroanalytics chat: width and position on the screen, overlaid or side-by-side with the content. Settings are restored after page reload. The minimum chat width has also been increased to 400 px.
* Fixed the display of tooltips in selectors on dashboards when using formulas.
* Fixed an issue where, on some iOS versions, a selector value would reset immediately after being selected.
* Fixed [chart cross-filtering](../dashboard/chart-chart-filtration.md) for maps in Firefox and Safari browsers.


* Updated the design of the [billing account](../settings/service-plan.md#billing-account) connection dialog in the [service settings](../settings/index.md).
* Fixed incorrect breadcrumb display when opening a chart in a workbook.


### Fixes in connections {#connection-fixes}

* Fixed authorization errors in [Google Sheets](../operations/connection/create-google-sheets.md) connections for tables with restricted access.
* Added `PUT` and `PATCH` to the allowed methods for [API Connector](../operations/connection/create-api-connector.md#restrictions) connections.
* Fixed an issue where the status of the data [export prohibition](../concepts/chart/data-export.md#data-export-disable) setting in [file](../operations/connection/create-file.md), [Yandex Documents](../operations/connection/create-yadocs.md), and [Google Sheets](../operations/connection/create-google-sheets.md) connections did not match the actual export capability.

### Fixes in datasets {#dataset-fixes}

* Fixed an error in datasets on the **Filtering** tab for the `Date and Time` field type, where the time was shifted by the user's time zone offset.
* Added information about the ability to edit the source in the dataset source update form.

### Fixes in reports {#report-fixes}

* Fixed a [report export](../reports/report-operations.md#report-export) error where text inside a cell was exported incorrectly in the **Chart** widget of the **Table** type.

### Dashboard fixes {#dashboard-fixes}

* Fixed an issue where repeated quick clicks on a chart on dashboards caused the widget to disappear.
* Fixed an issue with opening tooltips in pinned widgets on mobile devices.
* Fixed the simultaneous opening of two [background color](../dashboard/settings.md#dashboard-background) pick windows on dashboards in Safari.

### Fixes in charts {#chart-fixes}

* Fixed the legend display when coloring charts by measure.
* Fixed incorrect display of empty values in the **Filters from dashboard** section in charts opened from a dashboard.
* Fixed a [direct export](../concepts/chart/data-export.md#save-data) issue in `XLSX` format where the progress indicator would display indefinitely if the total row had an invalid date.
* Fixed an issue with color settings in the **Colors** section when using the default custom palette. Previously, colors would only appear after switching to another palette and back. Now all colors are immediately available for selection.
* Fixed the display of a [column chart](../visualization-ref/column-chart.md) with sorting and grouping by a field from the **Colors** section.
* For a [normalized stacked area chart](../visualization-ref/normalized-area-chart.md), removed the **Display mode** option in the **Y-axis** settings, which was shown incorrectly.
* In a [pie chart](../visualization-ref/pie-chart.md), fixed the display of the chart with a small sector size.
* For Editor charts, fixed an issue where manually added parameters were not displayed in selectors linked to datasets.

