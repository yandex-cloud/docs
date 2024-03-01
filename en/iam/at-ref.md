# {{ at-full-name }} audit log reference

{{ at-name }} for {{ iam-full-name }} supports tracking of [management (control plane) events](../audit-trails/concepts/format.md) and [data (data plane) events](../audit-trails/concepts/format-data-plane.md).

The general view of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.iam.<event_name>
```

## Management event reference {#control-plane-events}

{% include [iam-events](../_includes/audit-trails/events/iam-events.md) %}
