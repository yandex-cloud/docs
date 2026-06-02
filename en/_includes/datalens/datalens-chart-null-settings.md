* If the source data has a row with `null` for a measure value, this point will not be plotted on a chart with default settings.

    _For example, if the source has a row with the date, `20.07.2022`, but the sales total for it is not specified._

    To set up null value display on a chart:

    1. Click ![image](../../_assets/console-icons/gear.svg) in the top-right corner of the section with the measure you want to configure (the icon appears when you hover over the section).
    1. In **Empty values (null)**, select `Display as 0`.
    1. Click **Apply**. Now the chart will use `0` instead of `null`.

* If a row is missing from the source data altogether, the chart section settings will not change the chart. 

    _For example, if the source does not have a row with the particular date, `20.07.2022`, nothing will be shown for this date on the chart._

For more information, see [{#T}](../../datalens/operations/chart/chart-null-settings.md).
