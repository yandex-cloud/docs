---
title: '{{ billing-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ billing-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ billing-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.billing.<event_name>
```

{% include [billing-events](../_includes/audit-trails/events/billing-events.md) %}