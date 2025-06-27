---
title: '{{ sws-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ sws-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking [control plane](../audit-trails/concepts/format.md) and [data plane](../audit-trails/concepts/format-data-plane.md) events for {{ sws-full-name }}.

The `event_type` value follows this general format:

```text
{{ at-event-prefix }}.audit.smartwebsecurity.<event_name>
```

## Control plane event reference {#control-plane-events}

{% include [sws-events](../_includes/audit-trails/events/sws-events.md) %}

## Data plane event reference {#data-plane-events}

{% include [sws-events-dp](../_includes/audit-trails/events/sws-events-dp.md) %}
