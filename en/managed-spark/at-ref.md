---
title: '{{ msp-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ msp-name }} events tracked in {{ at-name }}.
---


# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ msp-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.spark.<event_name>
```


## Control plane event reference {#control-plane-events}

{% include [msp-events](../_includes/audit-trails/events/managed-spark-events.md) %}