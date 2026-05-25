---
title: '{{ mmg-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ mmg-name }} events monitored in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports monitoring of both [control plane](../audit-trails/concepts/format.md) (configuration level) and [data plane](../audit-trails/concepts/format-data-plane.md) (service level) events for {{ mmg-full-name }}.

The `event_type` format is as follows:

```text
{{ at-event-prefix }}.audit.mdb.mongodb.<event_name>
```

## Control plane event reference {#control-plane-events}

{% include [mongodb-events](../_includes/audit-trails/events/mongodb-events.md) %}

## Data plane event reference {#data-plane-events}

{% include [mmg-events-dp](../_includes/audit-trails/events/mmg-events-dp.md) %}