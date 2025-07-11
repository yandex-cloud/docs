---
title: '{{ translate-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ translate-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking data plane events for {{ translate-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The `event_type` value follows this general format:

```text
{{ at-event-prefix }}.audit.ai.translate.<event_name>
```

{% include [translate-events-dp](../_includes/audit-trails/events/translate-events-dp.md) %}