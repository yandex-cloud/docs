---
title: '{{ mpg-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ mpg-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking [control plane](../audit-trails/concepts/format.md) and [data plane](../audit-trails/concepts/format-data-plane.md) events for {{ mpg-full-name }}.

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.mdb.postgresql.<event_name>
```

## Management event reference {#control-plane-events}

{% include [mpg-events](../_includes/audit-trails/events/managed-postgresql-events.md) %}

## Data event reference {#data-plane-events}

{% include [mpg-events-dp](../_includes/audit-trails/events/mpg-events-dp.md) %}
