# {{ at-full-name }} audit log reference

{{ at-name }} supports tracking of management (control plane) events for {{ vpc-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general view of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.network.<event_name>
```

{% include [vpc-events](../_includes/audit-trails/events/vpc-events.md) %}