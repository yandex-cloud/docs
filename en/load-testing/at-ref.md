---
title: '{{ load-testing-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ load-testing-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ load-testing-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The `event_type` value follows this general format:

```text
{{ at-event-prefix }}.audit.loadtesting.<event_name>
```

{% include [load-testing-events](../_includes/audit-trails/events/load-testing-events.md) %}