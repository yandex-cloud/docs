# Selectors

Selectors are filters that affect the results of queries in the linked [widgets](./widget.md).


{% include [datalens-db-query-note](../../_includes/datalens/datalens-db-query-note.md) %}


A selector can be linked to a chart or another selector. For more information, see [{#T}](./link.md).

A single widget may [host](../operations/dashboard/add-selector.md) multiple selectors. Each of them works within one dashboard tab.

{{ datalens-short-name }} supports multiple selector types:

* **List**: Allows selecting one or multiple values from a list.
* **Input field**: Used for entering a field value manually.
* **Calendar**: Used for entering values of the `Date` or `Date and time` type.
* **Checkbox**: Allows selecting one of the two possible `Boolean` type values, `True` or `False`. To choose both boolean values, use the **List** selector type.


When adding a selector to a dashboard, consider how it affects chart filters:

* On a dashboard with no selector, the chart is displayed with an internal set of filters, if any.
* When adding a selector by a certain field to your dashboard, filters added at the chart level are no longer applied to the dashboard's chart.
* If no value is selected in the selector (`No selected values`), the chart is displayed without filtering by this field even if there is a filter by this field at the chart level.

To apply double filtering to a field (through a selector and chart filter), create a duplicate of this field in the chart. In this case, you can apply filtering to the duplicate within the chart and add a selector by the original field to the dashboard.

Filters applied to charts using selectors are displayed in the **Dashboard filters** section. It is available if you open the chart to edit from the dashboard. To clear all the dashboard filters, click ![image](../../_assets/console-icons/trash-bin.svg) in the top-left corner of the section.

#### See also {#see-also}

* [{#T}](../operations/dashboard/add-selector.md)
