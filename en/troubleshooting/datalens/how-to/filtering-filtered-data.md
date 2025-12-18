# How to filter previously filtered data using a selector



## Case description {#case-description}

You need to apply a selector to pre-filtered data, but when you apply a selector to a chart, the chart's field filters are reset.

## Solution {#case-resolution}

Dashboard-level filters have higher priority than chart-level filters. We suggest duplicating the field in the chart and leaving the original field in the dashboard filter.
