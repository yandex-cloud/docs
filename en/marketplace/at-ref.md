---
title: '{{ marketplace-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ marketplace-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking of management events for {{ marketplace-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.marketplace.licensemanager.<event_name>
```

{% include [marketplace-events](../_includes/audit-trails/events/marketplace-events.md) %}