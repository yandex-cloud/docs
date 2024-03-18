# {{ at-full-name }} event reference

{{ at-name }} supports tracking of management (control plane) events for {{ cdn-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general view of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.cdn.<event_name>
```

{% include [cdn-events](../_includes/audit-trails/events/cdn-events.md) %}