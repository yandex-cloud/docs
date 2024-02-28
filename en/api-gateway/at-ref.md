# {{ at-full-name }} audit log reference

{{ at-name }} supports tracking of management (control plane) events for {{ api-gw-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general view of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.serverless.apigateway.<event_name>
```

{% include [api-gw-events](../_includes/audit-trails/events/api-gw-events.md) %}