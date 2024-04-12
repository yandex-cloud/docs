# Events

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

