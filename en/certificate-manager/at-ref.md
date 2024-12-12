---
title: '{{ certificate-manager-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ certificate-manager-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking [control plane](../audit-trails/concepts/format.md) and [data plane](../audit-trails/concepts/format-data-plane.md) events for {{ certificate-manager-full-name }}.

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.certificatemanager.<event_name>
```

## Management event reference {#control-plane-events}

{% include [cm-events](../_includes/audit-trails/events/cm-events.md) %}

## Data event reference {#data-plane-events}

{% include [certificate-manager-events-dp](../_includes/audit-trails/events/certificate-manager-events-dp.md) %}