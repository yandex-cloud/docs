---
title: '{{ cns-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ cns-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} for {{ cns-full-name }} supports tracking [management events (control plane)](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.notifications.<event_name>
```

## Management event reference {#control-plane-events}

{% include [notifications-events](../_includes/audit-trails/events/notifications-events.md) %}
