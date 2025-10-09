---
title: '{{ vpc-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ vpc-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking [control plane](../audit-trails/concepts/format.md) and [data plane](../audit-trails/concepts/format-data-plane.md) events. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.network.<event_name>
```

## Control plane event reference {#control-plane-events}

{% include [vpc-events](../_includes/audit-trails/events/vpc-events.md) %}

## Data plane event reference {#data-plane-events}

{% include [vpc-events-dp](../_includes/audit-trails/events/vpc-events-dp.md) %}