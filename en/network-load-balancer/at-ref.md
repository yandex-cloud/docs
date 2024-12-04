---
title: '{{ network-load-balancer-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ network-load-balancer-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ network-load-balancer-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.loadbalancer.<event_name>
```

{% include [network-load-balancer-events](../_includes/audit-trails/events/network-load-balancer-events.md) %}