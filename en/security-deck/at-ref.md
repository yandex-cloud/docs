---
title: '{{ sd-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ sd-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports monitoring of both [control plane](../audit-trails/concepts/format.md) (configuration level) and [data plane](../audit-trails/concepts/format-data-plane.md) (service level) events for {{ sd-full-name }}.

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.securitydeck.<module_name><event_name>
```

## Control plane event reference {#control-plane-events}

### {{ cspm-full-name }} ({{ cspm-name }}) {#sd-cspm}

Module name: `cspm`.

{% include [sd-cspm-events](../_includes/audit-trails/events/sd-cspm-events.md) %}

### {{ kspm-full-name }} ({{ kspm-name }}) {#sd-kspm}

Module name: `kspm`.

{% include [sd-kspm-events](../_includes/audit-trails/events/sd-kspm-events.md) %}

### {{ alerts-name }} module {#sd-alerts}

Module name: `alerts`.

{% include [sd-alerts-events](../_includes/audit-trails/events/sd-alerts-events.md) %}

### {{ sd-name }} workspaces {#sd-orchestrator}

Module name: `orchestrator`.

{% include [sd-orchestrator-events](../_includes/audit-trails/events/sd-orchestrator-events.md) %}

## Data plane event reference {#data-plane-events}

### {{ atr-name }} module {#sd-access-transparency-dp}

Module name: `accesstransparency`.

{% include [sd-at-events-dp](../_includes/audit-trails/events/sd-at-events-dp.md) %}

### {{ cspm-full-name }} ({{ cspm-name }}) {#sd-cspm-dp}

Module name: `cspm`.

{% include [sd-cspm-events](../_includes/audit-trails/events/sd-cspm-events-dp.md) %}

### {{ kspm-full-name }} ({{ kspm-name }}) {#sd-kspm-dp}

Module name: `kspm`.

{% include [sd-kspm-events-dp](../_includes/audit-trails/events/sd-kspm-events-dp.md) %}

### {{ alerts-name }} module {#sd-alerts-dp}

Module name: `alerts`.

{% include [sd-alerts-events-dp](../_includes/audit-trails/events/sd-alerts-events-dp.md) %}
