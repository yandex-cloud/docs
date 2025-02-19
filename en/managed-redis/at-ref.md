---
title: '{{ mrd-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ mrd-name }} events tracked in {{ at-name }}.
---


# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ mrd-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.mdb.redis.<event_name>
```


## Management event reference {#control-plane-events}

{% include [mrd-events](../_includes/audit-trails/events/mrd-events.md) %}


## Data event reference {#data-plane-events}

{% include [mrd-events-dp](../_includes/audit-trails/events/mrd-events-dp.md) %}