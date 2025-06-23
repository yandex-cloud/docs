---
title: '{{ message-queue-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ message-queue-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} for {{ message-queue-full-name }} supports tracking [management events (control plane)](../audit-trails/concepts/format.md).

The `event_type` value follows this general format:

```text
{{ at-event-prefix }}.audit.ymq.<event_name>
```

## Control plane event reference {#control-plane-events}

{% include [ymq-events](../_includes/audit-trails/events/ymq-events.md) %}