# Widgets

Widgets are small cards with useful information. They can show lists of issues, statistics on issue completion, pivot tables, or notes. Widget content is generated automatically. The list of issues that a widget is based on is set using [filters](filters.md). You can go to [{#T}](../support-process.md#dashboards) to find sample widgets for the support service dashboard.

## List of issues {#section_ll1_zdp_pz}

![image](../../_assets/tracker/widgets/filter.png)

This widget allows you to view a list of issues that meet a specific filter. For example, you can use these widgets to set up a page where you can see both the issues in a particular queue and the issues that you are currently working on.

To configure a widget, make these settings:

- **Name**: The name to display in the widget title.
- **Results**: The number of issues to display on a single widget page. If there are more issues, you can navigate between pages at the bottom of the widget.
- **Filter**: The filter used for creating the list of issues. You can set the filter using a [direct link](filters.md), [name](create-filter.md), or the [query language](query-filter.md).
- **Columns**: The issue fields to show in the list. You can add multiple fields. To remove a field, click **x**.
- **Auto-update**: How often to refresh the widget data.

## Summary tables {#section_esm_vjp_pz}

Summary tables automatically collect statistics on issues and display them in a table. {{ tracker-name }} supports several types of summary tables:

#### Two-dimensional table

![image](../../_assets/tracker/widgets/table.png)

A simple pivot table that allows you to view statistics for any two parameters. The number of issues that meet the parameters is shown at intersections in the table. For instance, you can use a two-dimensional table to track the quantity and status of issues for a specific group of assignees.

To configure a widget, make these settings:

- **Name**: The name to display in the widget title.

- **Filter**. Statistics are gathered for issues that correspond to a specific filter. You can set the filter using a [direct link](filters.md), [name](create-filter.md), or the [query language](query-filter.md).

- **X axis**: The parameter to use for table columns.

- **Y axis**: The parameter to use for table rows.

- **Number of rows on page**: The maximum number of table rows to display in the widget. If there are more rows, you can use the **Show all** button at the bottom of the widget.

- **Sort by**: The order for sorting table rows.

- **Show total**: If this option is enabled, the table contains the sum of values for rows and columns.

- **Auto-update**: How often to refresh the widget data.

#### Two-dimensional table with sum of values

![image](../../_assets/tracker/widgets/table-with-sum.png)

A special type of pivot table with two parameters. In contrast to a simple two-dimensional table, the intersections show the sum of the values of a third parameter, instead of the number of issues. For instance, you can use this table to track the time spent by assignees working on various components in the queue.

To configure a widget, make these settings:

- **Name**: The name to display in the widget title.

- **Filter**. Statistics are gathered for issues that correspond to a specific filter. You can set the filter using a [direct link](filters.md), [name](create-filter.md), or the [query language](query-filter.md).

- **X axis**: The parameter to use for table columns.

- **Y axis**: The parameter to use for table rows.

- **Total for**: The parameter to show totals for in the intersections.

- **Number of rows on page**: The maximum number of table rows to display in the widget. If there are more rows, you can use the **Show all** button at the bottom of the widget.

- **Sort rows**: The sort order in table rows.

- **Sort columns**: The sort order in table columns.

- **Show total**: If this option is enabled, the table contains the sum of values for rows and columns.

- **Auto-update**: How often to refresh the widget data.

## Statistics {#section_htb_kvp_pz}

Statistics widgets automatically gather information on issues and display it in graphs and charts. {{ tracker-name }} supports multiple types of statistics widgets:

#### Issue statistics

![image](../../_assets/tracker/widgets/stat.png)

The widget displays the distribution of issues by the values of a specific parameter.

To configure the widget, make these settings:

- **Name**: The name to display in the widget title.

- **Filter**. Statistics are gathered for issues that correspond to a specific filter. You can set the filter using a [direct link](filters.md), [name](create-filter.md), or the [query language](query-filter.md).

- **Number of rows on page**: The maximum number of rows to display in the widget. If there are more rows, you can use the **Show all** button at the bottom of the widget.

- **Key parameter**: The issue field to gather statistics for.

- **Sort by**: The sort order of the columns.

- **Auto-update**: How often to refresh the widget data.

#### Events

![image](../../_assets/tracker/widgets/events.png)

The chart displays statistics for _events_ in issues over a certain period of time. You can choose one of the events:

- Work on the issue was completed. This event is defined by the **End date**.

- Work on the issue has started. This event is defined by the **Start date**.

- Last update to the issue.

- Last comment on the issue.

- Issue was switched to the **Resolved** status.

- Issue created.

To configure the widget, make these settings:

- **Name**: The name to display in the widget title.

- **Filter**. Statistics are gathered for issues that correspond to a specific filter. You can set the filter using a [direct link](filters.md), [name](create-filter.md), or the [query language](query-filter.md).

- **Key parameter**: Select the event to track in the statistics.

- **Group**: Select the step and specify the period for collecting statistics.

- **Show cumulative total**: If this option is enabled, data collected from previous steps is included in each subsequent step.

- **Auto-update**: How often to refresh the widget data.

#### <q>Created vs. Resolved chart</q>

![image](../../_assets/tracker/widgets/create-resolve.png)

This chart allows you to compare the number of created issues to the number of resolved issues. You can specify the period and step for collecting statistics.

To configure the widget, make these settings:

- **Name**: The name to display in the widget title.

- **Filter**. Statistics are gathered for issues that correspond to a specific filter. You can set the filter using a [direct link](filters.md), [name](create-filter.md), or the [query language](query-filter.md).

- **Group**: Select the step and specify the period for collecting statistics.

- **Show average value**: If this option is enabled, a trend line is displayed under the chart.

- **Show cumulative total**: If this option is enabled, data collected from previous steps is included in each subsequent step.

- **Show versions**: If this option is enabled, the chart shows the versions that issues are related to.

## Notes {#section_rtw_3gr_pz}

![image](../../_assets/tracker/widgets/note.png)

Write down your ideas and make notes right on the dashboard. You can enter notes in plain text or use [Wiki markup](wiki-markup.md).


[Contact support](../troubleshooting.md)

