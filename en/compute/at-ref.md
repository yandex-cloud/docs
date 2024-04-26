# {{ at-full-name }} event reference


{{ at-name }} supports tracking of management (control plane) events for {{ compute-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general view of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.compute.<event_name>
```

{% include [compute-events](../_includes/audit-trails/events/compute-events.md) %}