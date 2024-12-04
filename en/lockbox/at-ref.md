---
title: '{{ lockbox-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ lockbox-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking [control plane](../audit-trails/concepts/format.md) and [data plane](../audit-trails/concepts/format-data-plane.md) events for {{ lockbox-full-name }}.

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.lockbox.<event_name>
```

## Management event reference {#control-plane-events}

{% include [lockbox-events](../_includes/audit-trails/events/lockbox-events.md) %}

## Data event reference {#data-plane-events}

{% include [lockbox-events-dp](../_includes/audit-trails/events/lockbox-events-dp.md) %}