If the source data includes a row where the measure value is `null`, this point won't be shown on the chart at default settings. For example, if the source includes a row with a date (`20.07.2022`) but the sales amount is missing for it.

You can use settings for chart sections to show null values:

1. In the section with a measure whose values you want to show, in the upper-right corner, click ![image](../../_assets/datalens/gear.svg) (the icon appears when you hover over the section).
1. In **Empty values (null)**, select `Display as 0`.
1. Click **Apply**.

Now, the chart will use `0` instead of `null`.

If a row is missing in the source data, the chart section settings won't affect the measure display on the chart. For example, if the source data doesn't have a row with a certain date (`20.07.2022`), nothing will be shown for this date on the chart.

For more information, see [{#T}](../../datalens/operations/chart/chart-null-settings.md).
