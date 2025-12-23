---
title: '{{ mmy-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ mmy-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking [control plane](../audit-trails/concepts/format.md) and [data plane](../audit-trails/concepts/format-data-plane.md) events for {{ mmy-full-name }}.

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.mdb.mysql.<event_name>
```

## Control plane event reference {#control-plane-events}

{% include [mysql-events](../_includes/audit-trails/events/mysql-events.md) %}

## Data plane event reference {#data-plane-events}

{% include [mmy-events-dp](../_includes/audit-trails/events/mmy-events-dp.md) %}