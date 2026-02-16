---
title: '{{ datalens-full-name }} event reference in {{ at-full-name }}'
description: This page is a reference for {{ datalens-name }} management and data events tracked by {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} for {{ datalens-full-name }} supports tracking [management events (control plane)](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.datalens.<event_name>
```

## Management event reference {#control-plane-events}

{% include [datalens-events](../_includes/audit-trails/events/datalens-events.md) %}
