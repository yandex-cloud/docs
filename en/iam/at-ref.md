# {{ at-full-name }} event reference

{{ at-name }} supports tracking of [management (control plane) events](../audit-trails/concepts/format.md) and [data (data plane) events](../audit-trails/concepts/format-data-plane.md) for {{ iam-full-name }}.

The general view of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.iam.<event_name>
```

## Management event reference {#control-plane-events}

{% include [iam-events](../_includes/audit-trails/events/iam-events.md) %}

## Data event reference {#data-plane-events}

{% include [iam-events-dp](../_includes/audit-trails/events/iam-events-dp.md) %}
