---
title: "How to configure the navigator in {{ datalens-full-name }}"
description: "Follow this guide to set up the navigator."
---

# Configuring the navigator

{% note info %}

The navigator is available for those charts from the list that have a field of the `Date` or `Date and time` type in their **X** section:

* [Line chart](../../visualization-ref/line-chart.md)
* [Stacked area chart](../../visualization-ref/area-chart.md)
* [Normalized area chart](../../visualization-ref/normalized-area-chart.md)
* [Column chart](../../visualization-ref/column-chart.md)

{% endnote %}

To set up the navigator:


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. In the left-hand panel, click ![image](../../../_assets/console-icons/chart-column.svg) **Charts** and select a chart to set up the navigator for.
1. On the left side of the screen above the chart, click ![image](../../../_assets/console-icons/gear.svg).
1. In the **Chart settings** window, enable the **Navigator** option.
1. Select the navigator display mode:

   * **All lines** to display all chart lines in the navigator.
   * **Choose lines** to display the chosen lines in the navigator.

1. Specify the **Default period**. Each time you open the chart, the last period corresponding to this setting is displayed. Set `0` or leave the field empty to display the entire range of values.
1. Click **Apply**. The navigator is displayed at the bottom of the chart.

{% cut "Examples of operations with navigator" %}

![image](../../../_assets/datalens/chart-settings/02-navigator.gif).

{% endcut %}


