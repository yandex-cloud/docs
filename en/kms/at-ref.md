---
title: '{{ kms-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ kms-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking [control plane](../audit-trails/concepts/format.md) and [data plane](../audit-trails/concepts/format-data-plane.md) events for {{ kms-full-name }}.

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.kms.<event_name>
```

## Management event reference {#control-plane-events}

{% include [kms-events](../_includes/audit-trails/events/kms-events.md) %}

## Data event reference {#data-plane-events}

{% include [kms-events-dp](../_includes/audit-trails/events/kms-events-dp.md) %}