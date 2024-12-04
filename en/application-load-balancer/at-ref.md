---
title: '{{ alb-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ alb-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ alb-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.apploadbalancer.<event_name>
```

{% include [alb-events](../_includes/audit-trails/events/alb-events.md) %}
