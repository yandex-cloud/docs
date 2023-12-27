# {{ at-full-name }} audit log reference

{{ at-name }} supports tracking of management (Control Plane) events for {{ alb-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The value of the `event_type` field (_event type_) is determined by the source service of the event.

The general value format is as follows:

```text
{{ at-event-prefix }}.audit.apploadbalancer.<event_name>
```

{% include [alb-events](../_includes/audit-trails/events/alb-events.md) %}
