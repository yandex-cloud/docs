# {{ at-full-name }} event reference

{{ at-name }} supports tracking of management (control plane) events for {{ network-load-balancer-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general view of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.loadbalancer.<event_name>
```

{% include [network-load-balancer-events](../_includes/audit-trails/events/network-load-balancer-events.md) %}