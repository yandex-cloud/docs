---
title: '{{ ai-studio-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ ai-studio-full-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking [control plane](../audit-trails/concepts/format.md) and [data plane](../audit-trails/concepts/format-data-plane.md) events for {{ ai-studio-full-name }}.

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.ai.<event_name>
```

## Control plane event reference {#control-plane-events}

{% include [compute-events](../_includes/audit-trails/events/ai-studio-events.md) %}

## Data plane event reference {#data-plane-events}

{% include [ai-studio-events-dp](../_includes/audit-trails/events/ai-studio-events-dp.md) %}