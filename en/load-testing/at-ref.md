---
title: '{{ load-testing-full-name }} event reference in {{ at-full-name }}'
description: This page lists {{ load-testing-name }} events that can be tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{% include [loadtesting-sunset-warning](../_includes/load-testing/sunset-warning.md) %}


{{ at-name }} supports tracking control plane events for {{ load-testing-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` value is as follows:

```text
{{ at-event-prefix }}.audit.loadtesting.<event_name>
```

{% include [load-testing-events](../_includes/audit-trails/events/load-testing-events.md) %}