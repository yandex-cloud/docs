* If the source data has a row with `null` for value, this point will not be plotted on a chart with default settings.

    _For example, if the source has a row with a date (`20.07.2022`) but the sales total for it is not specified._

    To set up empty value display on a chart:

    1. Click ![image](../../_assets/console-icons/gear.svg) in the top-right corner of the section with the measure you want to configure (the icon appears on hover).
    1. In **Empty values (null)**, select `Display as 0`.
    1. Click **Apply**. Now the chart will use `0` instead of `null`.

* If a row is missing from the source data completely, the chart section settings will not change the way the chart is presented. 

    _For example, if the source does not have a row with a particular date (`20.07.2022`), nothing will be shown for this date on the chart._

For more information, see [{#T}](../../datalens/operations/chart/chart-null-settings.md).
