# {{ at-full-name }} audit log reference

{{ at-name }} supports tracking of management events (control plane) for {{ alb-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

General view of the `event_type` field value:

```text
{{ at-event-prefix }}.audit.apploadbalancer.<event_name>
```

{% include [alb-events](../_includes/audit-trails/events/alb-events.md) %}
