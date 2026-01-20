---
title: '{{ alb-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ alb-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking [control plane](../audit-trails/concepts/format.md) and [data plane](../audit-trails/concepts/format-data-plane.md) events for {{ alb-full-name }}.

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.apploadbalancer.<event_name>
```

{% include [about-events-ref](../_includes/audit-trails/about-events-ref.md) %}

## Control plane event reference {#control-plane-events}

{% include [alb-events](../_includes/audit-trails/events/alb-events.md) %}

## Data plane event reference {#data-plane-events}

{% include [alb-events-dp](../_includes/audit-trails/events/alb-events-dp.md) %}