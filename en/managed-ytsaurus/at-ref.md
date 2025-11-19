---
title: '{{ myt-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ myt-full-name }} events tracked in {{ at-name }}.
---


# {{ at-full-name }} event reference

{{ at-name }} supports tracking [management events](../audit-trails/concepts/format.md) (control plane). For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.video.<event_name>
```


## Control plane event reference {#control-plane-events}

{% include [ytsaurus-events](../_includes/audit-trails/events/ytsaurus-events.md) %}