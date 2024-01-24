### Why does a line connect points with missing values in-between and Display as 0 enabled? {#null-setting-in-charts}

If the source data includes a row where the measure value is `null`, the chart will not be built for that point at default settings (there will be a gap in the line, or column/point will be skipped). For example, if the source has a row with a date (`20.07.2022`) but the sales amount for it is missing.

You can configure how the chart will display null values in the chart section settings:

1. In the section with a measure whose values you want to show, in the top-right corner, click ![image](../../_assets/console-icons/gear.svg) (the icon appears when you hover over the section).
1. In **Empty values (null)**, select `Display as 0`.
1. Click **Apply**.

Now, `null` values will be replaced by `0` in the chart.

{% note info %}

The setting is only available for charts that have at least one **X** or **Y** axis:

* Line chart
* Area chart (Stacked and Normalized)
* Column chart (including a Normalized column chart)
* Bar chart (including a Normalized bar chart)
* Scatter chart

{% endnote %}

If a row is missing from the source data completely, the chart section settings will not change the way the chart is presented. For example, if the source does not have a row with a certain date (`20.07.2022`), nothing will be shown for this date on the chart. The values of fields with missing values in-between will be connected by a line.

For more information, see [{#T}](../../datalens/operations/chart/chart-null-settings.md).
