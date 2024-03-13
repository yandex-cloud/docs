# {{ at-full-name }} audit log reference

{{ at-name }} supports tracking of [management (control plane) events](../audit-trails/concepts/format.md) and [data (data plane) events](../audit-trails/concepts/format-data-plane.md) for {{ objstorage-full-name }}.

The general view of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.storage.<event_name>
```

## Management event reference {#control-plane-events}

{% include [storage-events](../_includes/audit-trails/events/storage-events.md) %}

## Data event reference {#data-plane-events}

{% include [storage-events-dp](../_includes/audit-trails/events/storage-events-dp.md) %}