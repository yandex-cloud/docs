---
title: '{{ mes-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ mes-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ mes-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.mdb.elasticsearch.<event_name>
```

{% include [mes-events](../_includes/audit-trails/events/mes-events.md) %}
