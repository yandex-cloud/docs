# Widgets

Widgets are small cards with useful information. They can show issue lists, statistics on issue completion, pivot tables, or notes. The widget content is generated automatically. The list of issues that a widget is based on is set using [filters](create-filter.md). To see sample widgets for your support team, see [{#T}](../support-process-dashboards.md).

## Issues {#tasks}

![](../../_assets/tracker/widgets/filter.png)

A widget enables you to view a list of issues that match a certain filter. With such widgets, you can use the same page to view your issue from a specific queue or your current issues.

To configure a widget, set the following:

- **Widget name**: Name to display in the widget header.
- **Number of issues per page**: Number of issues that are shown per widget page. If there are more issues, you can use page navigation at the bottom of the widget.
- **Issue source**: Filter on the basis of which the list of issues is formed. You can select a [system](default-filters.md) filter or a [previously created](create-filter.md) filter from the list or specify a filter using the [query language](query-filter.md) or parameters.
- **Columns**: Issue fields to show in the list. You can add multiple fields. To delete a field, click **x**.

## Note {#note}

![](../../_assets/tracker/widgets/note.png)

Put down your ideas and take notes directly on the dashboard. You can enter notes in plain text or use [markup](markup.md).

## Pivot table {#summary-table}

![](../../_assets/tracker/widgets/table.png)

A simple pivot table that enables you to view issue statistics by any pair of parameters. At the table intersections, you can see the number of issues that match the parameters. You can use this type of table, for instance, to track the quantity and status of issues for a specific group of assignees.

To configure a widget, set the following:

- **Widget name**: Name to display in the widget header.

- **Issue source**: Filter on the basis of which the list of issues is formed. You can select a [system](default-filters.md) filter or a [previously created](create-filter.md) filter from the list or specify a filter using the [query language](query-filter.md) or parameters.

- **Columns**: Parameter to use for table columns.

- **Rows**: Parameter to use for table rows.

- **Number of rows on page**: Maximum number of table rows to display in the widget. If there are more rows than the maximum, you can see them by clicking **{{ ui-key.startrek.ui_components_dashboard_TableWidget.show-all }}** at the bottom of the widget.

- **Sort by**: Order for sorting table rows.

- **Show total**: If this option is enabled, the table includes the total of all rows and columns.


## Summary table with totaled values {#summary-table-with-totals}

![](../../_assets/tracker/widgets/table-with-sum.png)

Special pivot table with two parameters. In contrast to a simple pivot table, the intersections show the sum of the values of a third parameter, instead of the number of issues. You can use this table to track the time spent by users on different queue components.

To configure a widget, set the following:

- **Widget name**: Name to display in the widget header.

- **Issue source**: Filter on the basis of which the list of issues is formed. You can select a [system](default-filters.md) filter or a [previously created](create-filter.md) filter from the list or specify a filter using the [query language](query-filter.md) or parameters.

- **Columns**: Parameter to use for table columns.

- **Rows**: Parameter to use for table rows.

- **Cells**: Parameter whose totals are displayed at intersections.

- **Number of rows on page**: Maximum number of table rows to display in the widget. If there are more rows than the maximum, you can see them by clicking **{{ ui-key.startrek.ui_components_dashboard_TableWidget.show-all }}** at the bottom of the widget.

- **Sort rows**: Sorting order for table rows.

- **Sort columns**: Sorting order for table rows.

- **Show total**: If this option is enabled, the table includes the total of all rows and columns.


## Events {#events}

![](../../_assets/tracker/widgets/events.png)

The chart displays _statistics for events_ in issues over a certain period of time. You can select one of the following events:

- Work on the issue is completed. This event is defined by **{{ ui-key.startrek-backend.fields.issue.end-key-value }}**.

- Work on the issue is started. This event is defined by **{{ ui-key.startrek-backend.fields.issue.start-key-value }}**.

- Latest issue update.

- Latest comment on the issue.

- Issue was switched to the **{{ ui-key.startrek-backend.applinks.samsara.status.resolved }}** status.

- The issue was created.

To configure a widget, set the following:

- **Widget name**: Name to display in the widget header.

- **Issue source**: Filter on the basis of which the list of issues is formed. You can select a [system](default-filters.md) filter or a [previously created](create-filter.md) filter from the list or specify a filter using the [query language](query-filter.md) or parameters.
- **Key parameter**: Select the event to track in the statistics.

- **Group**: Select the step and specify the period for collecting statistics.

- **Show cumulative total**: If this option is enabled, data collected from previous steps is included in each subsequent step.


## Issue statistics {#issues-stat}

![](../../_assets/tracker/widgets/stat.png)

The widget displays issue distribution by values of a certain parameter.

To configure a widget, set the following:

- **Widget name**: Name to display in the widget header.

- **Issue source**: Filter on the basis of which the list of issues is formed. You can select a [system](default-filters.md) filter or a [previously created](create-filter.md) filter from the list or specify a filter using the [query language](query-filter.md) or parameters.

- **Number of rows on page**: The maximum number of chart rows to display in the widget. If there are more rows than the maximum, you can see them by clicking **{{ ui-key.startrek.ui_components_dashboard_TableWidget.show-all }}** at the bottom of the widget.

- **Key parameter**: The issue field to gather statistics for.

- **Sort by**: The sort order in chart columns.


{% note info %}

In the **Key parameter** field, we do not recommend using the **{{ ui-key.startrek.ui_components_dashboard.summary-field-name }}** value because the widgets with such settings will soon be disabled. [Read more](../faq.md#section_del_widget).

{% endnote %}

## Created/Resolved chart {#created-and-resolved}

![](../../_assets/tracker/widgets/create-resolve.png)

The chart enables you to compare the number of created and closed issues. You can specify the period and step for collecting statistics.

To configure a widget, set the following:

- **Widget name**: Name to display in the widget header.

- **Issue source**: Filter on the basis of which the list of issues is formed. You can select a [system](default-filters.md) filter or a [previously created](create-filter.md) filter from the list or specify a filter using the [query language](query-filter.md) or parameters.

- **Group**: Select the step and specify the period for collecting statistics.

- **Show average value**: If this option is enabled, a trend line is displayed under the chart.

- **Show cumulative total**: If this option is enabled, data collected from previous steps is included in each subsequent step.

- **Show versions**: If this option is enabled, the chart shows the versions that issues belong to.



## Cycle time {#cycle-time}

{% include [cycle-time](../../_includes/tracker/cycle-time.md) %}

In {{ tracker-full-name }}, a cycle is a sequence from the initial stage to the completion of an issue.

The cycle time is a chart that allows you to analyze the time spent on a workflow. The chart shows the total time spent on all issue stages from first switching from the initial status to the last switching to the final status.

The control chart is an analytical tool that can be used to track deviations from a moving average cycle time calculated from a sample of issues within the specified period.

The widget combines both charts and allows you to estimate:
* Average time to complete the work within the organized workflow.
* Dynamics of changes for the selected period.
* Percentiles: what percentage of issues are closed and in what time frame.
* How long it takes on average to resolve an issue, from idea to completion.
* How much time will be required for testing and acceptance of the issue after the development is completed.
* Nature of deviations from the moving average cycle time.
* How many issues or defects of similar size can be completed in a certain period of time.

To configure a widget, set the following:

* **Name**: Name to display in the widget header.
* **Issue source**: Filter on the basis of which the list of issues is formed. You can select a [system](default-filters.md) filter or a [previously created](create-filter.md) filter from the list or specify a filter using the [query language](query-filter.md) or parameters.
* **Initial statuses**: Statuses in which work on the issue has started.
* **Final statuses**: Statuses in which the issue is considered resolved.
* **Period**: Period for generating the diagram.
* **Step**: Step value on the axis with period. The number of steps on the chart should be between 5 and 100, inclusive; otherwise, the chart analysis will be inefficient. If this condition is not met, you can reduce the step or increase the chart generation period. The step itself can take a value from 1 to 99.
* **Working hours**: Period of working time during the day.
* **Percentile**: Percentage of values in the data sample against which the percentile is calculated.
* **Moving average**: Option that adds an averaged time value line to the chart.
* **Standard deviation**: Option that adds a mean square deviation line to the chart. It can help you estimate how widely the values are scattered from the average.