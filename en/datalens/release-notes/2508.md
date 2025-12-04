---
title: '{{ datalens-full-name }} release notes: August 2025'
description: Check out {{ datalens-full-name }} release notes for August 2025.
---

# {{ datalens-full-name }} release notes: August 2025

* [Changes in basic features](#base)
* [Fixes and improvements](#fixes)
* [Changes available with the _Business_ service plan](#business)

## Changes in basic features {#base}

* Added [parameterization of dataset sources](../dataset/parametrization.md). This new feature allows you to dynamically substitute parameters from a chart into an SQL query, table name, or schema name.


* Added highlighting of features available with the Business [service plan](../concepts/service-plans-comparison.md) to the service settings.

  ![image](../../_assets/datalens/release-notes/business-setting.png =552x167)

* Revamped the [chart](../concepts/chart/index.md) menu on dashboards:

  * By default, in the web version, the chart menu on the dashboard is now hidden from view and appears when hovering over the widget. On mobile devices, the menu is visible at all times.
  * The cross-filtering icon no longer overlaps notifications.
  * Notification icons have become less bright.
  * Changed the order of UI controls.


* In [tables](../visualization-ref/table-chart.md) and [pivot tables](../visualization-ref/pivot-table-chart.md):
  
  * Hid pagniation if a single page is displayed or there is no data.
  * In the measure settings window, moved the setting for field fill color selection in hex format. To change the color:

    1. Click the button with the current color.
    1. In the pop-up window, select a color from the color palette or click ![icon](../../_assets/console-icons/pencil-to-line.svg) and specify a color in hex format. The color will change in the settings window.

       ![image](../../_assets/datalens/release-notes/table-measure-color-setting-hex.png =346x375)

    1. Click anywhere outside the pop-up window with the color palette.


## Fixes and improvements {#fixes}


### UI fixes {#interface-fixes}

* In {{ datalens-gallery }}, fixed icon positioning in the drop-down list of the **Use** menu.
* In the dialog box for [configuring access permissions to workbooks and collections](../workbooks-collections/security.md), fixed scrolling display and added display of the full user name or group name when hovering over a permission subject.
* In the dialog box for copying and transferring a workbook, fixed breadcrumb alignment and scrolling display.
* Fixed the issue with attachment previews in the [support](../qa/index.md#how-to-resolve-problem) request form.


### Fixes in connections {#connections-fixes}

Fixed the incorrect behavior when opening a form for creating a Yandex Documents connection from the [Yandex Documents](../operations/connection/create-yadocs.md) connection page in the navigation panel.

### Fixes in charts {#chart-fixes}

* Hid the **Axis type** setting in [QL charts](../concepts/chart/ql-charts.md) rendered with the Gravity UI [Yagr](https://github.com/gravity-ui/yagr) library.
* Now, in QL charts, the query may take up the whole width of the query editor window.
* Fixed the issue with displaying the name of the selected connection when creating a QL chart.
* Fixed the position of the navigation window when changing connections in QL charts.
* In [point maps](../visualization-ref/point-map-chart.md) based on QL charts, fixed issues with changing the point size and tooltip display.
* In [tables](../visualization-ref/table-chart.md#set-field-color), fixed filling of cells with empty (`null`) values. Now, such cells are not filled if the `Do not fill` option is selected in the **Colors** section.
* Fixed incorrect tooltip display.
* Fixed the error when displaying the empty (`null`) value in an [indicator](../visualization-ref/indicator-chart.md) built using the [markup functions](../function-ref/markup-functions.md).
* When changing a dataset in the [wizard](../concepts/chart/dataset-based-charts.md), the navigation window now opens in the current directory.
* Fixed the error in [labels](../concepts/chart/settings.md#sign) when `&amp;` and `&lt;&gt;` were displayed instead of the `&` and `<>` characters when using the [BR](../function-ref/BR.md) markup function.
* Fixed incorrect display of the legend and labels in [pie](../visualization-ref/pie-chart.md) charts. Previously, a measure name was displayed in the legend and labels in case there was an empty row among dimensions.
* Optimized the display of the gradient legend for dimensions.



## Changes available with the _Business_ service plan {#business}

### Fixes in Editor {#editor-fixes}

* In [Advanced charts](../charts/editor/widgets/advanced.md), fixed the tooltip display when moving the cursor.
* Fixed the issue with changing the background color when copying widgets in dashboards and reports.
* Fixed the display of Gravity UI Charts in reports with configured scaling.

