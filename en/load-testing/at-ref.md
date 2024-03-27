# {{ at-full-name }} event reference

{{ at-name }} supports tracking of management (control plane) events for {{ load-testing-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general view of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.loadtesting.<event_name>
```

{% include [load-testing-events](../_includes/audit-trails/events/load-testing-events.md) %}