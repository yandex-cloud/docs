---
title: '{{ compute-full-name }} event reference in {{ at-full-name }}'
description: This page is a reference for {{ compute-name }} management and data events tracked by {{ at-name }}.
---

# {{ at-full-name }} event reference


{{ at-name }} supports tracking [control plane](../audit-trails/concepts/format.md) and [data plane](../audit-trails/concepts/format-data-plane.md) events for {{ compute-full-name }}.

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.compute.<event_name>
```

## Management event reference {#control-plane-events}

{% include [compute-events](../_includes/audit-trails/events/compute-events.md) %}

## Data event reference {#data-plane-events}

{% include [compute-events-dp](../_includes/audit-trails/events/compute-events-dp.md) %}
