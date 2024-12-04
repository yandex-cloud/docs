---
title: '{{ certificate-manager-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ certificate-manager-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ certificate-manager-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.certificatemanager.<event_name>
```

{% include [cm-events](../_includes/audit-trails/events/cm-events.md) %}
