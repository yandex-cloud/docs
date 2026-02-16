---
title: '{{ speechkit-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ speechkit-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking data plane events for {{ speechkit-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The `event_type` value follows this general format:

```text
{{ at-event-prefix }}.audit.ai.speechkit.<event_name>
```

{% include [speechkit-events-dp](../_includes/audit-trails/events/speechkit-events-dp.md) %}