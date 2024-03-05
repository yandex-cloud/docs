# {{ at-full-name }} audit log reference

{{ at-name }} for {{ dns-full-name }} supports tracking of [management events](../audit-trails/concepts/format.md) (control plane) and [data events](../audit-trails/concepts/format-data-plane.md) (data plane).

The general view of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.dns.<event_name>
```

## Management event reference {#control-plane-events}

{% include [dns-events](../_includes/audit-trails/events/dns-events.md) %}

## Data event reference {#data-plane-events}

{% include [dns-events-dp](../_includes/audit-trails/events/dns-events-dp.md) %}