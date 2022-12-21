# Filter invalid value

`ERR.DS_API.FILTER.INVALID_VALUE`

Invalid filter value.

The error occurs if the chart accepts an invalid parameter as a filter. For example, the dashboard passes a parameter with a `String` type to filter data by a numeric field in the chart.

To fix this error:

1. In the dashboard, click **Edit**.
1. Click ![image](../../../_assets/datalens/gear.svg) in the upper-right corner of the widget that issues such an error.
1. Delete the invalid parameter from the parameter list in the widget settings.
1. Save your widget and dashboard.
