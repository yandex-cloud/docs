---
title: '{{ vpc-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ vpc-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ vpc-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.network.<event_name>
```

{% include [vpc-events](../_includes/audit-trails/events/vpc-events.md) %}