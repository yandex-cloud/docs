---
title: '{{ mkf-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ mkf-name }} events monitored in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking [control plane events](../audit-trails/concepts/format.md) and [data plane events](../audit-trails/concepts/format-data-plane.md) for {{ mkf-full-name }}.

The `event_type` field value format is as follows:

```text
{{ at-event-prefix }}.audit.mdb.kafka.<event_name>
```

## Control plane event reference {#control-plane-events}

{% include [managed-kafka-events](../_includes/audit-trails/events/managed-kafka-events.md) %}

## Data plane event reference {#data-plane-events}

{% include [mkf-events-dp](../_includes/audit-trails/events/mkf-events-dp.md) %}