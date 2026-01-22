---
title: '{{ baremetal-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ baremetal-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ baremetal-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.baremetal.<event_name>
```

{% include [about-events-ref](../_includes/audit-trails/about-events-ref.md) %}

{% include [baremetal-events](../_includes/audit-trails/events/baremetal-events.md) %}