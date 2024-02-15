# {{ at-full-name }} audit log reference

{{ at-name }} for {{ kms-full-name }} supports tracking of [management (control plane) events](../audit-trails/concepts/format.md) and [data (data plane) events](../audit-trails/concepts/format-data-plane.md).

The general view of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.kms.<event_name>
```

## Management event reference {#control-plane-events}

{% include [kms-events](../_includes/audit-trails/events/kms-events.md) %}

## Data event reference {#data-plane-events}

{% include notitle [preview](../_includes/note-preview-by-request.md) %}

{% include [kms-events-dp](../_includes/audit-trails/events/kms-events-dp.md) %}
