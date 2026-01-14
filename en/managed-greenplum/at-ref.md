---
title: '{{ mgp-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ mgp-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking [control plane events](../audit-trails/concepts/format.md) and [data plane events](../audit-trails/concepts/format-data-plane.md) for {{ mgp-full-name }}.

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.mdb.greenplum.<event_name>
```

## Control plane event reference {#control-plane-events}

{% include [mgp-events](../_includes/audit-trails/events/managed-greenplum-events.md) %}

## Data plane event reference {#data-plane-events}

{% include [mgp-events](../_includes/audit-trails/events/mgp-events-dp.md) %}

{% include [greenplum-trademark](../_includes/mdb/mgp/trademark.md) %}