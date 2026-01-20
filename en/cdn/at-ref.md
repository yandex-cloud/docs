---
title: '{{ cdn-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ cdn-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ cdn-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.cdn.<event_name>
```

{% include [about-events-ref](../_includes/audit-trails/about-events-ref.md) %}

{% include [cdn-events](../_includes/audit-trails/events/cdn-events.md) %}