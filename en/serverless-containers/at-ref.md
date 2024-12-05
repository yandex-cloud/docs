---
title: '{{ serverless-containers-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ serverless-containers-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ serverless-containers-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.serverless.containers.<event_name>
```

{% include [serverless-containers-events](../_includes/audit-trails/events/serverless-containers-events.md) %}