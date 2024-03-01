# {{ at-full-name }} audit log reference

{{ at-name }} supports tracking of management (control plane) events for {{ mos-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general view of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.mdb.opensearch.<event_name>
```

{% include [mos-events](../_includes/audit-trails/events/mos-events.md) %}
