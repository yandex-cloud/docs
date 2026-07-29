---
title: '{{ sw-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ sw-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking [control plane](../audit-trails/concepts/format.md) (management) and [data plane](../audit-trails/concepts/format-data-plane.md) (data) events for {{ sw-full-name }}.

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.serverless.workflows.<event_name>
```

## Management event reference {#control-plane-events}

{% include [workflows-events](../_includes/audit-trails/events/workflows-events.md) %}

## Data event reference {#data-plane-events}

{% include [workflows-events-dp](../_includes/audit-trails/events/workflows-events-dp.md) %}
