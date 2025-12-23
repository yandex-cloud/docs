---
title: '{{ maf-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ maf-name }} events tracked in {{ at-name }}.
---


# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ maf-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.airflow.<event_name>
```


## Control plane event reference {#control-plane-events}

{% include [maf-events](../_includes/audit-trails/events/managed-airflow-events.md) %}