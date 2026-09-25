---
title: '{{ datalens-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ datalens-name }} management and data events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} for {{ datalens-full-name }} supports tracking [management events (control plane)]({{ link-docs }}/audit-trails/concepts/format).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.datalens.<event_name>
```

## Management event reference {#control-plane-events}

{% include [datalens-events](../_includes/audit-trails/events/datalens-events.md) %}
