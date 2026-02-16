---
title: '{{ vision-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ vision-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking data plane events for {{ vision-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The `event_type` value follows this general format:

```text
{{ at-event-prefix }}.audit.ai.ocr.<event_name>
```

{% include [vision-events-dp](../_includes/audit-trails/events/vision-events-dp.md) %}