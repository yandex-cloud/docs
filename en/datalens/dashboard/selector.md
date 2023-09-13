# Selectors

Selectors are filters that affect the results of queries in their widgets. To add a selector to a dashboard, go to [{#T}](../operations/dashboard/add-selector.md).
A selector can be linked to a chart or another selector.
For more information, see [{#T}](./link.md).

A selector works within a single dashboard tab.

When adding a selector to a dashboard, consider how it affects chart filters:

* On a dashboard with no selector, the chart is displayed with an internal set of filters, if any.
* When adding a selector by a certain field to your dashboard, filters added at the chart level are no longer applied to the dashboard's chart.
* If no value is selected in the selector (`No selected values`), the chart is displayed without filtering by this field even if there is a filter by this field at the chart level.

To apply double filtering to a field (through a selector and chart filter), create a duplicate of this field in the chart. In this case, you can apply filtering to the duplicate within the chart and add a selector by the original field to the dashboard.

Filters applied to charts using selectors are displayed in the **Dashboard filters** section. It's available if you open the chart to edit from the dashboard. To clear all the dashboard filters, click ![image](../../_assets/datalens/delete.svg) in the upper-left corner of the section.

#### See also {#see-also}

* [{#T}](../operations/dashboard/add-selector.md)