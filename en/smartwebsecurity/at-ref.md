# {{ at-full-name }} event reference

{{ at-name }} supports tracking [control plane](../audit-trails/concepts/format.md) and [data plane](../audit-trails/concepts/format-data-plane.md) events for {{ sws-full-name }}.

The general view of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.smartwebsecurity.<event_name>
```

## Management event reference {#control-plane-events}

{% include [sws-events](../_includes/audit-trails/events/sws-events.md) %}

## Data event reference {#data-plane-events}

{% include [sws-events-dp](../_includes/audit-trails/events/sws-events-dp.md) %}
