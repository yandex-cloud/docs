---
title: '{{ metadata-hub-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ metadata-hub-name }} events tracked in {{ at-name }}.
---

# {{ metadata-hub-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ metastore-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.metastore.<event_name>
```

{% include [hive-metastore-events](../_includes/audit-trails/events/hive-metastore-events.md) %}