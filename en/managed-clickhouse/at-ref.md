---
title: '{{ mch-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ mch-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking [control plane](../audit-trails/concepts/format.md) and [data plane](../audit-trails/concepts/format-data-plane.md) events.

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.mdb.clickhouse.<event_name>
```

## Control plane event reference {#control-plane-events}

{% include [mch-events](../_includes/audit-trails/events/mch-events.md) %}

## Data plane event reference {#data-plane-events}

{% include [mch-events-dp](../_includes/audit-trails/events/mch-events-dp.md) %}

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
