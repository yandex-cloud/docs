---
title: '{{ datalens-full-name }} release notes: July 2025'
description: "Check out the {{ datalens-full-name }} release notes for July\_2025."
---

# {{ datalens-full-name }} release notes: July 2025

* [Changes in basic features](#base)
* [Fixes and improvements](#fixes)
* [Changes available with the _Business_ service plan](#business)

## Changes in basic features {#base}

* Added the ability to specify suggestions for [dashboard](../operations/dashboard/add-title.md) titles.
* Now you can set not only the background color but also the text color for dashboard titles.

  ![image](../../_assets/datalens/release-notes/title-hint-dashboard.png =453x306)

* Added [multi-selection](../dataset/create-dataset.md#bulk-changes) for [dataset](../dataset/index.md) fields. You can perform it by holding **Shift** and clicking fields one by one.

  ![image](../../_assets/datalens/release-notes/fields-multiselect.png)


* New works available in [{{ datalens-gallery }}]({{ link-datalens-main }}/gallery). For more information, see the [{{ datalens-short-name }}](https://t.me/YandexDataLens/28631/136577) Telegram chat.
* Added the option to select a [collection or workbook](../workbooks-collections/index.md) when deploying a product from {{ datalens-gallery }}. You can also create a new collection or workbook at this step.

  ![image](../../_assets/datalens/release-notes/deploy-to-wb.png =465x415)

* Now you can enable a [Business](../concepts/service-plans-comparison.md) [trial period](../pricing.md#prices) for 30 days.


## Fixes and improvements {#fixes}

### Fixes in charts {#chart-fixes}

* Fixed the display order of objects in the **Polylines** layer in [maps](../visualization-ref/polyline-map-chart.md).
* Fixed the automatic substitution of [measure names](../concepts/chart/measure-values.md) in [QL charts](../concepts/chart/ql-charts.md).
* Fixed the export data error in CSV format in charts on the chart preview page.
* Fixed the display of the linear [indicator](../visualization-ref/indicator-chart.md) for null values.
* Fixed the table structure change when switching to [pivot table](../../datalens/visualization-ref/pivot-table-chart.md) format.
* Fixed the display of scroll in tables with linear indicators.


### Fixes in dashboards {#dashboard-fixes}

* Tooltips in the pinned dashboard areas are now displayed fully without being clipped off at the edges of the pinned area.
* Fixed the addition of the `_no_controls` and `_embedded` parameters when inserting a widget using a link.
* Now you can paste multiple values from the clipboard to dashboard selectors.



### Mobile version fixes {#mobile-version-fixes}

Fixed the display of [chart](../concepts/chart/index.md) menu items in mobile version.


## Changes available with the _Business_ service plan {#business}

* Fixed the display of tabs in [Editor](../charts/editor/index.md).
* Added URL-overridden parameters panel in Editor.

  ![image](../../_assets/datalens/release-notes/editor-url-parameters-panel.png =726x46)

* Fixed color palette rounding when rounding is enabled in branding.
* Now you can set not only the background color but also the text color for report titles.
* Added the ability to specify suggestions for [report](../reports/report-operations.md#report-widget-settings) titles.

  ![image](../../_assets/datalens/release-notes/title-hint-report.png =453x259)

