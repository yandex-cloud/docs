---
title: '{{ ydb-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ ydb-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} for {{ ydb-full-name }} supports tracking [management events (control plane)](../audit-trails/concepts/format.md).

The general format of the `event_type` value is as follows:

```text
{{ at-event-prefix }}.audit.ydb.<event_name>
```

## Management event reference {#control-plane-events}

{% include [ydb-events](../_includes/audit-trails/events/ydb-events.md) %}