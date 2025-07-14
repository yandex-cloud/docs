---
title: '{{ dataproc-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ dataproc-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ dataproc-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The `event_type` value follows this general format:

```text
{{ at-event-prefix }}.audit.dataproc.<event_name>
```

{% include [dataproc-events](../_includes/audit-trails/events/data-processing-events.md) %}
