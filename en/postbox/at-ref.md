---
title: '{{ postbox-full-name }} event reference'
description: This section provides descriptions of the {{ at-full-name }} audit events collected in {{ postbox-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ postbox-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.postbox.<event_name>
```

{% include [postbox-events](../_includes/audit-trails/events/postbox-events.md) %}