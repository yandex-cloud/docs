---
title: '{{ mos-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ mos-name }} events monitored in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports monitoring of both [control plane](../audit-trails/concepts/format.md) (configuration level) and [data plane](../audit-trails/concepts/format-data-plane.md) (service level) events for {{ mos-full-name }}.

The `event_type` field value format is as follows:

```text
{{ at-event-prefix }}.audit.mdb.opensearch.<event_name>
```

## Control plane event reference {#control-plane-events}

{% include [mos-events](../_includes/audit-trails/events/mos-events.md) %}

## Data plane event reference {#data-plane-events}

{% include [mos-events-dp](../_includes/audit-trails/events/mos-events-dp.md) %}
