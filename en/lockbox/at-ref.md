# {{ at-full-name }} audit log reference

{{ at-name }} for {{ lockbox-full-name }} supports tracking of [management (control plane) events](../audit-trails/concepts/format.md) and [data (data plane) events](../audit-trails/concepts/format-data-plane.md).

The general view of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.lockbox.<event_name>
```

## Management event reference {#control-plane-events}

{% include [lockbox-events](../_includes/audit-trails/events/lockbox-events.md) %}

## Data event reference {#data-plane-events}

{% include notitle [preview](../_includes/note-preview-by-request.md) %}

{% include [lockbox-events-dp](../_includes/audit-trails/events/lockbox-events-dp.md) %}
