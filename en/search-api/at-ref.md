---
title: '{{ search-api-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ search-api-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ search-api-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.searchapi.<event_name>
```

{% include [searchapi-events](../_includes/audit-trails/events/searchapi-events.md) %}