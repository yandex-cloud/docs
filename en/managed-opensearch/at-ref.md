---
title: '{{ mos-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ mos-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ mos-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.mdb.opensearch.<event_name>
```

{% include [mos-events](../_includes/audit-trails/events/mos-events.md) %}
