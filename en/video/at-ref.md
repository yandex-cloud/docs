---
title: '{{ video-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ video-full-name }} events tracked in {{ at-name }}.
---


# {{ at-full-name }} event reference

{{ at-name }} supports tracking [management events](../audit-trails/concepts/format.md) (control plane). For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.video.<event_name>
```


## Management event reference {#control-plane-events}

{% include [video-events](../_includes/audit-trails/events/video-events.md) %}