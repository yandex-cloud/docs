---
title: '{{ org-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ org-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking [control plane](../audit-trails/concepts/format.md) and [data plane](../audit-trails/concepts/format-data-plane.md) events for {{ org-full-name }}.

The `event_type` value follows this general format:

```text
{{ at-event-prefix }}.audit.organizationmanager.<event_name>
```

## Control plane event reference {#control-plane-events}

{% include [org-events](../_includes/audit-trails/events/org-events.md) %}

## Data plane event reference {#data-plane-events}

{% include [org-events-dp](../_includes/audit-trails/events/org-events-dp.md) %}
