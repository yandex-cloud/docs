### Why does a line connect points with missing values in-between and Display as 0 enabled? {#null-setting-in-charts}

If the source data has a row with `null` for a measure value, this point will not be plotted on a chart with default settings. On the chart, it will appear as a line gap, skipped column or point. For example, if the source has a row with the date, `20.07.2022`, but the sales total for it is not specified.

You can configure how the chart will display null values in the chart section settings:

1. Click ![image](../../_assets/console-icons/gear.svg) in the top-right corner of the section with the measure you want to configure (the icon appears when you hover over the section).
1. In **Empty values (null)**, select `Display as 0`.
1. Click **Apply**.

Now, `null` values will be replaced by `0` in the chart.

{% note info %}

This setting is only available for charts that have at least one **X** or **Y** axis:

* Line chart
* Area chart (stacked and normalized)
* Column chart (including normalized)
* Bar chart (including normalized)
* Scatter chart

{% endnote %}

If a row is missing from the source data altogether, the chart section settings will not change the chart. For example, if the source does not have a row with the particular date, `20.07.2022`, nothing will be shown for this date on the chart. The values of fields with missing values in-between will be connected by a line.

For more information, see [{#T}](../../datalens/operations/chart/chart-null-settings.md).
