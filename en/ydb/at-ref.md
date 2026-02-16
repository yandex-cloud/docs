---
title: '{{ ydb-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ ydb-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ ydb-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.ydb.<event_name>
```

{% include [ydb-events](../_includes/audit-trails/events/ydb-events.md) %}