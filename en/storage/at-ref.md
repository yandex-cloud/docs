# {{ at-full-name }} audit log reference

{{ at-name }} for {{ objstorage-full-name }} supports tracking of [management events](../audit-trails/concepts/format.md) (control plane) and [data events](../audit-trails/concepts/format-data-plane.md) (data plane).

General view of the `event_type` field value:

```text
{{ at-event-prefix }}.audit.storage.<event_name>
```

## Management event reference

{% include [storage-events](../_includes/audit-trails/events/storage-events.md) %}

## Data event reference

{% include notitle [preview](../_includes/note-preview-by-request.md) %}

{% include [storage-events-dp](../_includes/audit-trails/events/storage-events-dp.md) %}