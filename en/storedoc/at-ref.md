---
title: '{{ mmg-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ mmg-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking [control plane](../audit-trails/concepts/format.md) and [data plane](../audit-trails/concepts/format-data-plane.md) events for {{ mmg-full-name }}.

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.mdb.mongodb.<event_name>
```

## Management event reference {#control-plane-events}

{% include [mongodb-events](../_includes/audit-trails/events/mongodb-events.md) %}

## Data event reference {#data-plane-events}

{% include [mmg-events-dp](../_includes/audit-trails/events/mmg-events-dp.md) %}