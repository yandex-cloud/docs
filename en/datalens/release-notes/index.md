---
title: '{{ datalens-full-name }} release notes: December 2024'
description: Check out {{ datalens-full-name }} release notes for December 2024.
---

# {{ datalens-full-name }} release notes: December 2024


* [Changes in basic features](#base)
* [Changes available with the _Business_ service plan](#business)
* [Mobile version updates](#mobile-version-changes)

## Changes in basic features {#base}



### Celebration UI theme {#festive-theme}

Added a setting to display the celebration UI theme: in the the left-hand panel, click ![image](../../_assets/console-icons/gear.svg) **Settings** → **Appearance** and select **Celebration theme**.

### Adding an anchor link {#anchor-link}

Now you can add anchor links to [dashboard](../dashboard/widget.md#title) headers. To add a link, enable the **Show anchor links** option in the widget editing window. Then you will see the `#` icon when hovering over a header with an anchor link. Clicking the icon adds a hash to the dashboard link. The page will scroll to that header when you click the anchor link.

### Setting up QL chart table size {#ql-chart-size}

Fixed applying the [table size setting](../visualization-ref/table-chart.md#table-size-settings) in [QL charts](../concepts/chart/ql-charts.md).

### Pivot table fixes {#pivot-table-fixes}

Fixed the following [pivot tables](../visualization-ref/pivot-table-chart.md) issues:

* Incorrect display of column names for `Date` type fields.
* Incorrect display of null values in rows.
* Totals displaying the first row only.

### Changes in area charts {area-chart-changes}

* Changed the **Stacked area chart** type name to [Area chart](../visualization-ref/area-chart.md).
* Added the **Stacking** [setting](../concepts/chart/settings.md#common-settings). It enables stacked or isolated data display for each category in the area chart. Possible values:

  * **On**: Displays stacked data.
  * **Off**: Displays unstacked data.

### Coloring in selectors {#selector-color-accent}

Added the **Coloring** option to selector settings to highlight important selectors.

### Axis on chart {#axis-on-chart}

Fixed the issue with the **Axis on chart** setting where an axis reappeared when editing a chart again after setting the value to `Hide`.

### Maximum Y-axis value for normalized charts {#normed-charts-max-on-y}

Fixed the maximum **Y-axis** value for fields with fractional value in normalized charts. Now the default maximum value is `100`.

### Redesign of title and text settings {#title-text-settings-redesign}

Updated the design of [Title](../dashboard/widget.md#title) and [Text](../dashboard/widget.md#text) widget settings.

### Viewing change history of dashboard objects {#object-history-dashboard}

Now only users with permissions to edit the dashboard can view the change history of dashboard objects.



## Changes available with the _Business_ service plan {#business}

### Changes in reports {#reports-changes}

* In a [report](../reports/index.md), you can now open the chart editing interface from the ![image](../../_assets/console-icons/ellipsis.svg) widget menu.
* Added the contrast mode to the [report settings](../reports/report-operations.md#report-settings). Possible values: `Standard` or `High`.


## Mobile version updates {#mobile-version-changes}

Names of single chart widgets are now fully displayed.