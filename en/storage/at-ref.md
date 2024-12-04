---
title: '{{ objstorage-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ objstorage-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking [control plane](../audit-trails/concepts/format.md) and [data plane](../audit-trails/concepts/format-data-plane.md) events for {{ objstorage-full-name }}.

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.storage.<event_name>
```

## Management event reference {#control-plane-events}

{% include [storage-events](../_includes/audit-trails/events/storage-events.md) %}

## Data event reference {#data-plane-events}

{% include [storage-events-dp](../_includes/audit-trails/events/storage-events-dp.md) %}