---
title: '{{ mspqr-full-name }} event reference in {{ at-full-name }}'
description: This page is a reference for {{ mspqr-name }} management and data events tracked by {{ at-name }}.
---

# {{ at-full-name }} event reference


{{ at-name }} supports tracking [control plane events](../audit-trails/concepts/format.md) and [data plane events](../audit-trails/concepts/format-data-plane.md) for {{ mspqr-full-name }}.

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.mdb.spqr.<event_name>
```

{% include [about-events-ref](../_includes/audit-trails/about-events-ref.md) %}

## Control plane event reference {#control-plane-events}

{% include [mspqr-events](../_includes/audit-trails/events/mspqr-events.md) %}

## Data plane event reference {#data-plane-events}

{% include [mspqr-events-dp](../_includes/audit-trails/events/mspqr-events-dp.md) %}
