---
title: '{{ cloud-desktop-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ cloud-desktop-full-name }} events tracked in {{ at-name }}.
---


# {{ at-full-name }} event reference

{{ at-name }} supports tracking [control plane](../audit-trails/concepts/format.md) and [data plane](../audit-trails/concepts/format-data-plane.md) events for {{ cloud-desktop-full-name }}.

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.clouddesktop.<event_name>
```

## Control plane event reference {#control-plane-events}

{% include [clouddesktop-events](../_includes/audit-trails/events/clouddesktop-events.md) %}

## Data plane event reference {#data-plane-events}

{% include [clouddesktop-events-dp](../_includes/audit-trails/events/clouddesktop-events-dp.md) %}