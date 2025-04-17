---
title: '{{ cloud-desktop-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ cloud-desktop-full-name }} events tracked in {{ at-name }}.
---


# {{ at-full-name }} event reference

{{ cloud-desktop-name }} supports tracking [management events (control plane)](../audit-trails/concepts/format.md). For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.clouddesktop.<event_name>
```


## Management event reference {#control-plane-events}

{% include [clouddesktop-events](../_includes/audit-trails/events/clouddesktop-events.md) %}