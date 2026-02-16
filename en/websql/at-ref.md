---
title: '{{ websql-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ websql-name }} events tracked in {{ at-name }}.
---

# {{ websql-full-name }} event reference

{{ at-name }} supports tracking [control plane](../audit-trails/concepts/format.md) and [data plane](../audit-trails/concepts/format-data-plane.md) events for {{ websql-full-name }}.

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.websql.<event_name>
```

## Management event reference {#control-plane-events}

{% include [websql-events](../_includes/audit-trails/events/websql-events.md) %}

## Data event reference {#data-plane-events}

{% include [websql-events-dp](../_includes/audit-trails/events/websql-events-dp.md) %}