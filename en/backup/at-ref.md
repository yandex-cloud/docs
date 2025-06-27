---
title: '{{ backup-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ backup-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ backup-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The `event_type` value follows this general format:

```text
{{ at-event-prefix }}.audit.backup.<event_name>
```

{% include [backup-events](../_includes/audit-trails/events/backup-events.md) %}