---
title: "How to configure the display of null values"
description: "Follow this guide to configure the display of null values."
---

# Configuring the display of null values

{% note info %}

The setting is only available for charts that have at least one X or Y axis:

* Line chart
* Area chart (Stacked and Normalized)
* Column chart (including a Normalized column chart)
* Bar chart (including a Normalized bar chart)
* Scatter chart

{% endnote %}

If the source data includes a row where the measure value is `null`, the chart will not be built for that point at default settings (there will be a gap in the line, or column/point will be skipped). For example, if the source has a row with a date (`20.07.2022`) but the sales amount for it is missing.

{% cut "Example of a chart with a gap" %}

![image](../../../_assets/datalens/operations/chart/line-chart-null.png =700x495)

**Source table**

| OrderDate | Sales |
| --------- | --------- |
| 15.07.2022 | 301629 |
| 16.07.2022 | 453595 |
| 17.07.2022 | 977583 |
| 18.07.2022 | 527834 |
| 19.07.2022 | 870054 |
| 20.07.2022 | null |
| 21.07.2022 | 569650 |
| 22.07.2022 | 1116034 |
| 23.07.2022 | 883208 |
| 24.07.2022 | 2359483 |
| 25.07.2022 | 1137851 |

{% endcut %}

You can configure how the chart will display null values in the chart section settings:

1. In the section with a measure whose values you want to show, in the upper-right corner, click ![image](../../../_assets/datalens/gear.svg) (the icon appears when you hover over the section).
1. Specify a value for the **Null values** option:

   * **Ignore**: Do not show points with `null` values. On the chart, it will appear as a line gap, skipped column or point.
   * **Connect**: Connect neighboring points with values other than `null` with a line.
   * **Display as 0**: Replace `null` values with `0`.

1. Click **Apply**.

{% cut "Example of replacing null with 0" %}

![image](../../../_assets/datalens/operations/chart/line-chart-null-0.png =700x495)

{% endcut %}

If a row is missing from the source data completely, the **Null values** option will not change the way the chart is presented. For example, if the source does not have a row with a certain date (`20.07.2022`), nothing will be shown for this date on the chart.

{% cut "Example of a chart with a missing date" %}

![image](../../../_assets/datalens/operations/chart/line-chart-no-rec.png =700x495)

**Source table**

| OrderDate | Sales |
| --------- | --------- |
| 15.07.2022 | 301629 |
| 16.07.2022 | 453595 |
| 17.07.2022 | 977583 |
| 18.07.2022 | 527834 |
| 19.07.2022 | 870054 |
| 21.07.2022 | 569650 |
| 22.07.2022 | 1116034 |
| 23.07.2022 | 883208 |
| 24.07.2022 | 2359483 |
| 25.07.2022 | 1137851 |

{% endcut %}

{% note info %}

To display a zero value for a date missing from the table:

1\. Add a row with this date and a `null` value to the source.
2\. In the chart settings for the relevant indicator, select **Display as 0** for the **Null values** option.

{% endnote %}
