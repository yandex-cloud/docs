# Resolving an incorrect `Total` value in a pivot table 


## Issue description {#issue-description}

Once added to the pivot table, the `Total` field values are displayed incorrectly.

## Solution {#issue-resolution}

In pivot tables, row values are calculated using the same formulas as the measure aggregation. However, the totals row does not display results calculated with LOD expressions, window functions, and time series functions.

For more details, see [this guide](../../../datalens/visualization-ref/pivot-table-chart.md#add-totals).

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). When creating it, please attach a screenshot showing the incorrect values.
