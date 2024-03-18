# {{ at-full-name }} event reference

{{ at-name }} supports tracking of management (control plane) events for {{ managed-k8s-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general view of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.k8s.<event_name>
```

{% include [managed-k8s-events](../_includes/audit-trails/events/managed-k8s-events.md) %}