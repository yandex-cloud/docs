# {{ at-full-name }} audit log reference

{{ at-name }} supports tracking of [management (control plane) events](../audit-trails/concepts/format.md) and [data (data plane) events](../audit-trails/concepts/format-data-plane.md) for {{ mpg-full-name }}.

The general view of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.mdb.postgresql.<event_name>
```

## Management event reference {#control-plane-events}

{% include [mpg-events](../_includes/audit-trails/events/managed-postgresql-events.md) %}

## Data event reference {#data-plane-events}

{% include notitle [preview](../_includes/note-preview-by-request.md) %}

{% include [mpg-events-dp](../_includes/audit-trails/events/mpg-events-dp.md) %}
