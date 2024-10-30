# How to filter previously filtered data with a selector


## Scenario description {#case-description}

You need to use a selector to on pre-filtered data, but when you apply a selector to a chart, the chart's field filters are reset.

## Solution {#case-resolution}

Dashboard-level filters take precedence over chart-level filters. We suggest duplicating the field in the chart and leaving the original field in the dashboard filter.
