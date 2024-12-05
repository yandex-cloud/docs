---
title: '{{ api-gw-full-name }} event reference in {{ at-full-name }}'
description: This page gives a reference for {{ api-gw-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking control plane events for {{ api-gw-full-name }}. For more information, see [{#T}](../audit-trails/concepts/format.md).

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.serverless.apigateway.<event_name>
```

{% include [api-gw-events](../_includes/audit-trails/events/api-gw-events.md) %}