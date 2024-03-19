# {{ at-full-name }} audit log reference

{{ at-name }} supports tracking of management (control plane) events for {{ ydb-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general view of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.ydb.<event_name>
```

{% include [ydb-events](../_includes/audit-trails/events/ydb-events.md) %}