---
title: '{{ foundation-models-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ foundation-models-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking data plane events for {{ foundation-models-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format-data-plane.md).

The `event_type` value follows this general format:

```text
{{ at-event-prefix }}.audit.ai.foundationmodel.<event_name>
```

{% include [foundation-models-dp](../_includes/audit-trails/events/foundation-models-dp.md) %}