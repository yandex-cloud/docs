---
title: '{{ mtr-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ mtr-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ mtr-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The `event_type` value follows this general format:

```text
{{ at-event-prefix }}.audit.trino.<event_name>
```

{% include [mtr-events](../_includes/audit-trails/events/managed-trino-events.md) %}