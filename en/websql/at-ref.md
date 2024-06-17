# {{ websql-full-name }} event reference

{{ at-name }} supports tracking of [management (control plane) events](../audit-trails/concepts/format.md) and [data (data plane) events](../audit-trails/concepts/format-data-plane.md) for {{ websql-full-name }}.

The general view of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.websql.<event_name>
```

## Management event reference {#control-plane-events}

{% include [websql-events](../_includes/audit-trails/events/websql-events.md) %}

## Data event reference {#data-plane-events}

{% include [websql-events-dp](../_includes/audit-trails/events/websql-events-dp.md) %}