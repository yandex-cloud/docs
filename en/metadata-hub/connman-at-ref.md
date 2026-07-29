---
title: '{{ connection-manager-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ connection-manager-name }} events tracked in {{ at-name }}.
---

# {{ connection-manager-full-name }} event reference

{{ at-name }} for {{ connection-manager-full-name }} supports tracking [management events](../audit-trails/concepts/format.md) (control plane).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.connectionmanager.<event_name>
```

## Management event reference {#control-plane-events}

{% include [connectionmanager-events](../_includes/audit-trails/events/connectionmanager-events.md) %}
