# Measure filter is unsupported for this type of query

`ERR.DS_API.FILTER.MEASURE_UNSUPPORTED`

The error occurs when a measure-based selector is linked to another selector on the dashboard.
When you create a selector on a dashboard, it is automatically [linked](../../dashboard/link.md):

* To all the charts on the dashboard tab created from the same dataset.
* To all the selectors on the dashboard tab created from the same dataset.

To fix this error:

1. With the dashboard in edit mode, click **Links** in the top right-hand corner.
1. Select the measure-based selector and unlink it from the others (set **Ignore** as the link type).
