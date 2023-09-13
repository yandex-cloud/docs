# Widgets

Widgets are small cards with useful information. They can show issue lists, statistics on issue completion, pivot tables, or notes. The widget content is generated automatically. The list of issues that a widget is based on is set using [filters](create-filter.md). To see sample widgets for your support team, see [{#T}](../support-process-dashboards.md).

## Issues {#tasks}

![](../../_assets/tracker/widgets/filter.png)

A widget enables you to view a list of issues that match a certain filter. With such widgets, you can use the same page to view your issue from a specific queue or your current issues.

To configure a widget, set the following:

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.hint-name }}**: Name displayed in the widget header.
- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-per-page }}**: Number of issues displayed on a single widget page. If there are more issues, you can use page navigation at the bottom of the widget.
- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-filter }}**: Filter used to generate the issue list. You can set filters using [direct links, names](create-filter.md), or the [query language](query-filter.md).
- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-fields }}**: Issue fields shown in the list. You can add multiple fields. To delete a field, click **x**.

## {{ ui-key.startrek.blocks-desktop_dashboard-create-zone.note-title }} {#note}

![](../../_assets/tracker/widgets/note.png)

Put down your ideas and take notes directly on the dashboard. You can enter notes in plain text or use [markup](markup.md).

## {{ ui-key.startrek.blocks-desktop_dashboard-create-zone.table-title }} {#summary-table}

![](../../_assets/tracker/widgets/table.png)

A simple summary table that enables you to view issue statistics by any pair of parameters. At the table intersections, you can see the number of issues that match the parameters. You can use this type of table, for instance, to track the quantity and status of issues for a specific group of assignees.

To configure a widget, set the following:

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.hint-name }}**: Name displayed in the widget header.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-filter }}**. Statistics are collected by issues that match a certain filter. You can set filters using [direct links, names](create-filter.md), or the [query language](query-filter.md).

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-x-axis }}**: Parameter used for table columns.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-y-axis }}**: Parameter used for table rows.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-on-first-page }}**: Maximum number of table rows to display in the widget. If there are more rows than the maximum, you can see them by clicking **{{ ui-key.startrek.ui_components_dashboard_TableWidget.show-all }}** at the bottom of the widget.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-sort }}**: Sorting order for table rows.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-show-sum }}**: If this option is enabled, the table includes the total of all rows and columns.


## {{ ui-key.startrek.blocks-desktop_dashboard-create-zone.table-sum-title }} {#summary-table-with-totals}

![](../../_assets/tracker/widgets/table-with-sum.png)

Special pivot table with two parameters. In contrast to a simple pivot table, the intersections show the sum of the values of a third parameter, instead of the number of issues. You can use this table to track the time spent by users on different queue components.

To configure a widget, set the following:

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.hint-name }}**: Name displayed in the widget header.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-filter }}**. Statistics are collected by issues that match a certain filter. You can set filters using [direct links, names](create-filter.md), or the [query language](query-filter.md).

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-x-axis }}**: Parameter used for table columns.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-y-axis }}**: Parameter used for table rows.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-sum }}**: Parameter whose totals are displayed at intersections.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-on-first-page }}**: Maximum number of table rows to display in the widget. If there are more rows than the maximum, you can see them by clicking **{{ ui-key.startrek.ui_components_dashboard_TableWidget.show-all }}** at the bottom of the widget.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.sort-row }}**: Sorting order for table rows.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.sort-column }}**: Sorting order for table columns.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-show-sum }}**: If this option is enabled, the table includes the total of all rows and columns.


## {{ ui-key.startrek.blocks-desktop_dashboard-create-zone.time-since-title }} {#events}

![](../../_assets/tracker/widgets/events.png)

The chart displays _statistics for events_ in issues over a certain period of time. You can select one of the following events:

- Work on the issue is completed. This event is defined by **{{ ui-key.startrek-backend.fields.issue.end-key-value }}**.

- Work on the issue is started. This event is defined by **{{ ui-key.startrek-backend.fields.issue.start-key-value }}**.

- Latest issue update.

- Latest comment on the issue.

- Issue was switched to the **{{ ui-key.startrek-backend.applinks.samsara.status.resolved }}** status.

- The issue was created.

To configure a widget, set the following:

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.hint-name }}**: Name displayed in the widget header.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-filter }}**. Statistics are collected by issues that match a certain filter. You can set filters using [direct links, names](create-filter.md), or the [query language](query-filter.md).

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-field }}**: Select an event to track in the statistics.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-group-by }}**: Select a step and set the period for collecting statistics.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-is-cumulative }}**: If this option is enabled, data collected from previous steps is included in each subsequent step.


## {{ ui-key.startrek.blocks-desktop_dashboard-create-zone.issues-title }} {#issues-stat}

![](../../_assets/tracker/widgets/stat.png)

The widget displays issue distribution by values of a certain parameter.

To configure a widget, set the following:

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.hint-name }}**: Name displayed in the widget header.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-filter }}**. Statistics are collected by issues that match a certain filter. You can set filters using [direct links, names](create-filter.md), or the [query language](query-filter.md).

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-on-first-page }}**: Maximum number of chart rows to display in the widget. If there are more rows than the maximum, you can see them by clicking **{{ ui-key.startrek.ui_components_dashboard_TableWidget.show-all }}** at the bottom of the widget.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-field }}**: Issue field to gather statistics for.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-sort }}**: Sorting order for chart columns.


{% note info %}

We do not recommend using the **{{ ui-key.startrek.ui_components_dashboard.summary-field-name }}** value in the **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-field }}** field because the widgets with this setting will soon be disabled. [Read more](../faq.md#section_del_widget).

{% endnote %}

## {{ ui-key.startrek.blocks-desktop_dashboard-create-zone.created-vs-resolved-title }} {#created-and-resolved}

![](../../_assets/tracker/widgets/create-resolve.png)

The chart enables you to compare the number of created and closed issues. You can specify the period and step for collecting statistics.

To configure a widget, set the following:

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.hint-name }}**: Name displayed in the widget header.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-filter }}**. Statistics are collected by issues that match a certain filter. You can set filters using [direct links, names](create-filter.md), or the [query language](query-filter.md).

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-group-by }}**: Select a step and set the period for collecting statistics.

- **Show average value**: If this option is enabled, a trend line is displayed under the chart.

- **Show cumulative total**: If this option is enabled, data collected from previous steps is included in each subsequent step.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.versions }}**: If this option is enabled, the chart shows the versions issues belongs to.


