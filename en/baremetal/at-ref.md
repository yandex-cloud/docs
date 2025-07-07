---
title: '{{ baremetal-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ baremetal-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ baremetal-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The `event_type` value follows this general format:

```text
{{ at-event-prefix }}.audit.baremetal.<event_name>
```

{% include [baremetal-events](../_includes/audit-trails/events/baremetal-events.md) %}