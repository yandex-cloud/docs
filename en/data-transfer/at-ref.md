# {{ at-full-name }} event reference

{{ at-name }} supports tracking of management (control plane) events for {{ data-transfer-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general view of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.datatransfer.<event_name>
```

{% include [datatransfer-events](../_includes/audit-trails/events/datatransfer-events.md) %}
